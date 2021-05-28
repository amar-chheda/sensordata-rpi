import sqlite3
from loguru import logger
from sqlite3 import Error, Connection, Cursor
from typing import Dict
import time
import hashlib as hash

@logger.catch
def _insert(_cur: Cursor, _query: str, _data: tuple) -> None:

    _cur.execute(_query, _data)

@logger.catch    
def _generateTimeID(val1: str, val2: str, val3: str) -> str:

    string = ''.join([val1,val2,val3])
    hash_object = hash.sha256(bytes(string, encoding="raw_unicode_escape"))
    return hash_object.hexdigest()

@logger.catch
def _getSensorId(_cur: Cursor, _query: str) -> int:

    _cur.execute(_query)
    res = _cur.fetchall()
    if res:
        return res[0][0]
    else:
        return 999     

@logger.catch
def insert_into_database(db_path: str, query: Dict[str, str], data: Dict[str, str]) -> str:
    
    try:

        con = sqlite3.connect(db_path)
        cur = con.cursor()

        start = time.time()
        logger.info(" BEGIN INSERT TRANSACTIONS ")
        cur.execute("BEGIN TRANSACTION")

        ### insert uuid
        _insert(cur, query["uuid"], tuple([data["uuid"]]))

        ### insert sensor data
        for sensor in data["sensors"]:
            name = sensor['name']
            values = list(sensor.values())[1:]
            fetch_query = "SELECT sensor_id FROM sensors WHERE sensor_name = '{}'".format(name)
            sensor_id = _getSensorId(cur, fetch_query)
            timeID = _generateTimeID(str(data["timestamp"]), str(sensor_id), data["uuid"])
            values.append(timeID)
            _insert(cur, query["time"], tuple([timeID, data["timestamp"], sensor_id, data["uuid"]]))
            _insert(cur, query[name], tuple(values))

        cur.execute("COMMIT")
        end = time.time()

        logger.success(" Time taken for insert transactions: {} seconds ".format(end-start))

        return "success"

    except Error as e:

        logger.error(" DATABASE INSERTS FAILED WITH ERROR: {} ".format(e))    

        return "fail"