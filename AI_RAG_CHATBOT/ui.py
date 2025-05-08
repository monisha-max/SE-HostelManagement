import streamlit as st
import requests

st.set_page_config(page_title="Mahindra RAG Chatbot", page_icon="📚", layout="centered")

st.markdown("""
    <style>
    .title { font-size: 48px; font-weight: bold; color: #4F8BF9; text-align: center; }
    .subtitle { font-size: 20px; color: #888; text-align: center; margin-top: -20px; }
    .chat-bubble { background-color: white; color: black; padding: 16px; border-radius: 12px; margin: 8px 0; }
    .user-bubble { background-color: white; color: black; padding: 16px; border-radius: 12px; margin: 8px 0; text-align: right; }
    </style>
""", unsafe_allow_html=True)

# Title
st.markdown('<div class="title">📚 Mahindra University RAG Bot</div>', unsafe_allow_html=True)
st.markdown('<div class="subtitle">Ask anything about Mahindra University!</div>', unsafe_allow_html=True)
st.markdown("---")

# Chat interface
if "chat_history" not in st.session_state:
    st.session_state.chat_history = []

query = st.text_input("Your Question:", placeholder="What programs does Mahindra University offer?")

if st.button("Ask"):
    if query.strip():
        st.session_state.chat_history.append(("You", query))

        # Send query to backend
        try:
            response = requests.post("http://localhost:5000/ask", json={"query": query})
            answer = response.json().get("answer", "⚠️ No response from backend.")
        except Exception as e:
            answer = f"⚠️ Error: {e}"

        st.session_state.chat_history.append(("Bot", answer))

# Display chat history
for speaker, msg in st.session_state.chat_history:
    css_class = "user-bubble" if speaker == "You" else "chat-bubble"
    st.markdown(f'<div class="{css_class}"><strong>{speaker}:</strong><br>{msg}</div>', unsafe_allow_html=True)
