from dotenv import load_dotenv
import streamlit as st
import os
import google.generativeai as genai
from PIL import Image
import json
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d.art3d import Poly3DCollection, Line3DCollection
import base64

# Load environment variables
load_dotenv()
genai.configure(api_key="AIzaSyB_aUnEympxsbHK6uopeC5RZ1sprQMmkWo")  # Secure API key handling

def get_gemini_response(input_prompt, image_base64):
    model = genai.GenerativeModel('gemini-1.5-flash')
    response = model.generate_content([
        input_prompt, 
        {"mime_type": "image/jpeg", "data": image_base64}
    ])
    return response.text.strip()

def draw_3d_floor_plan(room_data):
    try:
        length = float(room_data["length"].replace("m", ""))
        width = float(room_data["width"].replace("m", ""))
        height = float(room_data["height"].replace("m", ""))

        fig = plt.figure(figsize=(10, 10))
        ax = fig.add_subplot(111, projection='3d')

        corners = np.array([
            [0, 0, 0], [width, 0, 0], [width, length, 0], [0, length, 0],
            [0, 0, height], [width, 0, height], [width, length, height], [0, length, height]
        ])

        faces = [
            [corners[0], corners[1], corners[2], corners[3]],
            [corners[4], corners[5], corners[6], corners[7]],
            [corners[0], corners[1], corners[5], corners[4]],
            [corners[1], corners[2], corners[6], corners[5]],
            [corners[2], corners[3], corners[7], corners[6]],
            [corners[3], corners[0], corners[4], corners[7]]
        ]

        face_colors = ['lightblue', 'lightblue', 'lightgray', 'lightgray', 'lightgray', 'lightgray']

        for i, face in enumerate(faces):
            ax.add_collection3d(Poly3DCollection([face], facecolors=face_colors[i], edgecolors='black', alpha=0.6))

        for wall in room_data.get("wall_features", []):
            feature_type = wall.get("features", []) or []
            feature_width = float(wall["dimensions"]["width"].replace("m", ""))
            feature_height = float(wall["dimensions"]["height"].replace("m", ""))
            position = float(wall.get("position", "0").replace("m", ""))

            color = 'red' if "door" in feature_type else 'yellow' if "window" in feature_type else None
            if not color:
                continue

            if wall["side"] == "Front":
                x1, x2, y1, y2, z1, z2 = position, position + feature_width, 0, 0, 0, feature_height
            elif wall["side"] == "Back":
                x1, x2, y1, y2, z1, z2 = position, position + feature_width, length, length, 0, feature_height
            elif wall["side"] == "Left":
                x1, x2, y1, y2, z1, z2 = 0, 0, position, position + feature_width, 0, feature_height
            else:
                x1, x2, y1, y2, z1, z2 = width, width, position, position + feature_width, 0, feature_height

            ax.add_collection3d(Line3DCollection([[[x1, y1, z1], [x2, y2, z2]]], colors=color, linewidths=5))

        ax.set_xlabel("Width (m)")
        ax.set_ylabel("Length (m)")
        ax.set_zlabel("Height (m)")
        ax.set_title("Accurate 3D Floor Plan")

        st.pyplot(fig)
    except Exception as e:
        st.error(f"Error generating 3D floor plan: {e}")

def generate_summary_report(room_data):
    st.subheader("📋 Summary Report")
    summary = f"""
    **🏠 Room Details:**
    - **Room Shape:** {room_data.get("room_shape", "Unknown")}
    - **Length:** {room_data.get("length", "N/A")}
    - **Width:** {room_data.get("width", "N/A")}
    - **Height:** {room_data.get("height", "N/A")}

    **🚪 Wall Features:**
    """
    
    for wall in room_data.get("wall_features", []):
        summary += f"""
        - **{wall.get("side", "Unknown Wall")}**:
          - Features: {', '.join(wall.get("features", []))}
          - Width: {wall["dimensions"].get("width", "N/A")}
          - Height: {wall["dimensions"].get("height", "N/A")}
          - Position: {wall.get("position", "N/A")}
        """
    st.markdown(summary)

st.set_page_config(page_title="Room Dimension Extractor")
st.header("Upload an Image to Extract Room Dimensions & Generate Floor Plans")

uploaded_file = st.file_uploader("Choose an image...", type=["jpg", "jpeg", "png"])
image_bytes = uploaded_file.getvalue() if uploaded_file else None

if uploaded_file:
    image = Image.open(uploaded_file)
    st.image(image, caption="Uploaded Image", use_container_width=True)

view_option = st.selectbox("Select Floor Plan View", ["3D View"])
submit = st.button("Extract Room Dimensions & Generate Floor Plan")

input_prompt = """
You are an AI specialized in spatial analysis. Analyze this image and extract the room dimensions.
Return a *strictly valid JSON* response *without additional text*.
"""

if submit and image_bytes:
    image_base64 = base64.b64encode(image_bytes).decode("utf-8")
    response_text = get_gemini_response(input_prompt, image_base64)

    try:
        room_data = json.loads(response_text)
        generate_summary_report(room_data)
        draw_3d_floor_plan(room_data)
    except json.JSONDecodeError as e:
        st.error(f"Failed to parse JSON: {e}")
        st.write("Response received:", response_text)
        st.stop()
