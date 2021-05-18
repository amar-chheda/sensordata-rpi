from flask import Flask
from flask import request
import json
import sqlite3
from loguru import logger

app = Flask(__name__)

@app.route("/", methods=['POST'])
def index():
    data = request.get_json()
    print(data)
    return json.dumps({'success':True}), 200, {'contentType':'application/json'}


if __name__=="__main__":
    app.run(debug=True, port=80, host="0.0.0.0")