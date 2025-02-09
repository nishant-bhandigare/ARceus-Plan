import streamlit as st
import requests
import os
import base64
import json
import google.generativeai as genai
from langdetect import detect
from dotenv import load_dotenv

# ✅ FIRST COMMAND: Set Streamlit Page Config
st.set_page_config(page_title="Interior Design Q&A Bot", layout="centered")

# Load API keys from .env file
load_dotenv()
GOOGLE_API_KEY = "AIzaSyB_aUnEympxsbHK6uopeC5RZ1sprQMmkWo"
SARVAM_API_KEY = "506b3087-a45f-4dba-aabd-11a148639d37"

# Check if API keys are loaded
if not GOOGLE_API_KEY:
    st.error("GOOGLE_API_KEY is missing. Please check your .env file.")
if not SARVAM_API_KEY:
    st.stop()
    
if not SARVAM_API_KEY:
    st.error("SARVAM_API_KEY is missing. Please check your .env file.")
    st.stop()

# Configure Google Gemini API
genai.configure(api_key=GOOGLE_API_KEY)

# 🔹 Custom CSS for Yellow Theme
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

# 🎨 App UI - Title and Input
st.header(" Interior Design Q&A Bot")
user_question = st.text_input(" Ask your interior design question:")

# 🔹 AI Response Prompt Template
PROMPT_TEMPLATE = """
You are an expert in interior design and architecture.
Your job is to provide clear and practical advice to users.

*App Features:*
- Scans spaces and generates floor plans.
- Simulates furniture layouts.
- Provides realistic wall previews under different lighting.
- Gives AI-driven spatial insights.

*Rules:*
1. Keep answers short (max 500 characters).
2. Use simple, informative language.
3. Reply in the same language as the query.

Now, answer this question in 500 characters or less:  
*User Query:* {query}
"""

# 🔹 Function to get AI-generated responses using Google Gemini
def get_gemini_response(query):
    try:
        detected_lang = detect(query)  # Detect the language of the query
        model = genai.GenerativeModel('gemini-1.5-flash')
        prompt = PROMPT_TEMPLATE.format(query=query)
        response = model.generate_content(prompt)

        return response.text[:500] if response else "Sorry, I couldn't generate a response.", detected_lang

    except Exception as e:
        st.error(f" Error fetching response from Gemini: {str(e)}")
        return " Failed to generate a response.", "en"

# 🔹 Function to convert text to speech using Sarvam AI
def generate_voice_response(text, language_code):
    url = "https://api.sarvam.ai/text-to-speech"

    # Map detected language to Sarvam AI language codes
    lang_map = {
        "en": "en-IN",
        "hi": "hi-IN",
        "mr": "mr-IN",
    }
    
    target_language = lang_map.get(language_code, "en-IN")  # Default to English
    
    payload = {
        "inputs": [text],
        "target_language_code": target_language,
        "speaker": "meera",
        "pitch": 0,
        "pace": 1.5,
        "loudness": 1.2,
        "speech_sample_rate": 8000,
        "enable_preprocessing": True,
        "model": "bulbul:v1"
    }
    
    headers = {'API-Subscription-Key': SARVAM_API_KEY}

    try:
        response = requests.post(url, json=payload, headers=headers)
        response.raise_for_status()  

        json_data = response.json()
        if "audios" not in json_data or not json_data["audios"]:
            st.error(" No audio data received. Check API request format.")
            return None  

        base64_string = json_data["audios"][0]
        wav_data = base64.b64decode(base64_string)

        audio_file_path = "response_audio.wav"
        with open(audio_file_path, "wb") as audio_file:
            audio_file.write(wav_data)

        return audio_file_path

    except requests.exceptions.RequestException as e:
        st.error(f" API Request Error: {str(e)}\nResponse: {response.text}")
        return None
    except json.JSONDecodeError:
        st.error(" Error decoding JSON response from Sarvam API.")
        return None
    except Exception as e:
        st.error(f" Unexpected error: {str(e)}")
        return None

# 🚀 Process Query and Generate Answer
if st.button(" Get Answer"):
    if user_question:
        st.write(" Processing your query...")

        # AI Response
        response_text, detected_lang = get_gemini_response(user_question)
        st.subheader(" Answer:")
        st.write(response_text)

        # Generate and play voice response
        audio_file = generate_voice_response(response_text, detected_lang)
        if audio_file:
            st.audio(audio_file, format="audio/wav")
            st.success(" Voice response generated successfully!")
        else:
            st.error(" Failed to generate speech. Please check API settings or try again.")
    else:
        st.warning(" Please enter a question!")