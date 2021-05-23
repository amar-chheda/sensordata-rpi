from flask import Flask
from flask import request
import json
import sqlite3
from loguru import logger
import yaml
import os
from db.dbconfig import create_database, create_connection

app = Flask(__name__)

@app.route("/", methods=['POST'])
def index():
    data = request.get_json()
    logger.info(" DATA RECEIVED: {} ".format(data))
    return json.dumps({'success':True}), 200, {'contentType':'application/json'}


if __name__=="__main__":

    ###load config files
    with open("./config.yaml", "r") as config_file:
        config = yaml.load(config_file, Loader=yaml.FullLoader)

    logs_path = config.get("log_file_path")
    log_name = config.get("log_file")

    ### log init functions
    logger.debug("Initiating logging, logs can be found in {}".format(logs_path))
    logger.add(os.path.join(logs_path, log_name), rotation="50 MB", format="{time} {level} {message}", level="DEBUG", colorize=True)

    db_name = config.get("database_name")
    db_path = config.get("database_path")
    script_path = config.get("sql_scripts_path")
    create_db_file = config.get("create_db_file")

    conn = create_connection(os.path.join(db_path, db_name))
    logger.debug(" CONNECTION FILE: {} ".format(conn))
    cursor = create_database(conn, os.path.join(script_path, create_db_file))
    logger.debug(" CURSOR FILE: {} ".format(cursor))

    app.run(debug=True, port=80, host="0.0.0.0")