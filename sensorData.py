from flask import Flask
from flask import request
import json
import sqlite3
from loguru import logger
import yaml
import os
from db.dbconfig import create_database, create_connection
from db.database_inserts import insert_into_database

app = Flask(__name__)

@app.route("/", methods=['POST'])
def index():
    data = request.get_json()
    assert type(data) == dict
    insert_into_database(os.path.join(db_path, db_name), insert_scripts["insert_queries"], data)
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
    sensor_table_inserts = config.get("sensor_table")

    conn = create_connection(os.path.join(db_path, db_name))
    logger.debug(" CONNECTION FILE: {} ".format(conn))
    cursor = create_database(conn, os.path.join(script_path, create_db_file))
    logger.debug(" CURSOR FILE: {} ".format(cursor))

    ### insert sensor data
    with open(os.path.join(script_path, sensor_table_inserts), "r") as file:
        cursor.executescript(file.read())

    ### get insert queries
    sql_insert_scripts = config.get("sql_inserts")
    with open(sql_insert_scripts, "r") as queries:
        insert_scripts = yaml.load(queries, Loader=yaml.FullLoader)    

    app.run(debug=True, port=80, host="0.0.0.0")