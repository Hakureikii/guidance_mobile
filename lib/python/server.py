# server.py
from flask import Flask, request, jsonify
from multinomialNB import test as t

app = Flask(__name__)
@app.route("/add", methods=["POST"])
def process_details():
    text = t.Analysis()
    details = request.get_json()  # parses the JSON body Flutter sends
    referral_details = details["aboutDetails"]
    analyze = text.evaluate(referral_details)
    intensity = text.intensity(referral_details)
    
    return jsonify({
            "intensity": intensity,
            "analysis": analyze,
        })# Flask converts dict -> JSON automatically
    
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)