# server.py
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/add", methods=["POST"])
def add_numbers():
    data = request.get_json()  # parses the JSON body Flutter sends
    a = data["a"]
    b = data["b"]
    result = a + b
    return jsonify({"result": result})  # Flask converts dict -> JSON automatically

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)