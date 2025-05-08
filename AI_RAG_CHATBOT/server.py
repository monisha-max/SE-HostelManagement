from flask import Flask, request, jsonify
from app import answer_query  # import from your existing RAG script

app = Flask(__name__)

@app.route("/ask", methods=["POST"])
def ask():
    data = request.get_json()
    query = data.get("query", "")
    if not query:
        return jsonify({"answer": "⚠️ No question received."})
    answer = answer_query(query)
    return jsonify({"answer": answer})

if __name__ == "__main__":
    app.run(port=5000)
