# server.py
from flask import Flask, request, jsonify
from multinomialNB import analysis as a

app = Flask(__name__)
@app.route("/add", methods=["POST"])
def process_details():
    text = a.Analysis()
    data = request.get_json()  # parses the JSON body Flutter sends
    student_data = data["studentData"]  # access the studentData key from the parsed JSON
    analyze = text.evaluate(student_data)
    intensity = text.intensity(student_data)
    
    return jsonify({
            "intensity": intensity,
            "analysis": analyze,
        })# Flask converts dict -> JSON automatically
    
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)