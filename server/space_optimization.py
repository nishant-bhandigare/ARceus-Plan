import os
import streamlit as st
from dotenv import load_dotenv
import google.generativeai as genai
from PIL import Image

# Load API keys from .env file
load_dotenv()
GOOGLE_API_KEY = "AIzaSyB_aUnEympxsbHK6uopeC5RZ1sprQMmkWo"

# Ensure API key is loaded
if not GOOGLE_API_KEY:
    st.error(" GOOGLE_API_KEY is missing. Please check your .env file.")
    st.stop()

# Configure Google Gemini API
genai.configure(api_key=GOOGLE_API_KEY)

# ✅ Function to process uploaded image for Gemini API
def prepare_image_data(uploaded_file):
    """Converts uploaded image to the required format for Gemini API."""
    if uploaded_file:
        bytes_data = uploaded_file.getvalue()
        return [{"mime_type": uploaded_file.type, "data": bytes_data}]
    return None

# ✅ Function to get AI response from Google Gemini Vision API
def get_gemini_analysis(image_data, user_requirements):
    """Sends room layout image to Gemini Vision API for analysis and optimization insights."""
    model = genai.GenerativeModel('gemini-1.5-flash')

    # AI Prompt for Analysis
    input_prompt = f"""
    You are an expert in space optimization and interior design.
    Analyze the uploaded room layout image and provide *data-driven insights* based on:
    
    - *Furniture arrangement* and optimal placement.
    - *Legroom & circulation space* calculations.
    - *Ergonomic balance* for usability.
    - *Aesthetic improvements* to enhance space.
    - *Actionable recommendations* to improve functionality and comfort.

    User-specific requirements: {user_requirements}

    Provide results in a *structured and practical format*.
    """

    try:
        response = model.generate_content([input_prompt, image_data[0]])
        return response.text
    except Exception as e:
        return f" AI Processing Error: {str(e)}"

# ✅ Streamlit App UI
st.set_page_config(page_title=" Space Optimization Insights", layout="centered")

# ✅ Custom CSS Styling (Yellow Theme)
st.markdown(
    """
    <style>
    body {
        background-color: #ffeb3b !important;  /* Yellow Background */
    }
    .stApp {
        background-color: #ffeb3b !important;
        color: black !important;
    }
    .stTextInput>div>div>input {
        background-color: #fff59d !important;
        color: black !important;
    }
    .stButton>button {
        background-color: #ff9800 !important;
        color: white !important;
        border-radius: 10px;
        font-size: 16px;
    }
    .stButton>button:hover {
        background-color: #f57c00 !important;
    }
    .stAudio {
        background-color: #ffcc80 !important;
        padding: 10px;
        border-radius: 10px;
    }
    .stMarkdown h1, .stMarkdown h2, .stMarkdown h3 {
        color: black !important;
    }
    </style>
    """,
    unsafe_allow_html=True,
)

# ✅ App Header
st.header(" AI-Powered Space Optimization")
st.write(" Upload your *room layout image, and AI will provide **insights on space efficiency, furniture arrangement, and aesthetics*.")

# *User Input: Additional Preferences*
user_requirements = st.text_area(" Describe specific needs (optional):", placeholder="e.g., I want a cozy workspace with minimal furniture.")

# *Upload Room Layout Image*
uploaded_file = st.file_uploader(" Upload a room layout image...", type=["jpg", "jpeg", "png"])

# *Display Uploaded Image*
if uploaded_file:
    image = Image.open(uploaded_file)
    st.image(image, caption=" Uploaded Room Layout", use_column_width=True)

# *Analyze Button*
if st.button(" Analyze Space Optimization"):
    if uploaded_file:
        st.write(" *Processing your room layout...*")

        # *Prepare image for AI processing*
        image_data = prepare_image_data(uploaded_file)

        # *Get AI-generated insights*
        response = get_gemini_analysis(image_data, user_requirements)

        # *Display AI Response*
        st.subheader(" Optimization Insights:")
        st.write(response)
    else:
        st.warning(" Please upload a room layout image first!")