import sqlite3
from sqlite3 import Error, Connection, Cursor
from loguru import logger


def create_connection(db_file: str) -> Connection:

    conn = None

    try:
        conn = sqlite3.connect(db_file)
        logger.success(" CREATED DATABASE CONNECTION SUCCESSFULLY ")
        logger.info("SQLITE 3 VERSION - {}".format(sqlite3.version))
    
    except Error as e:
        logger.error(" DATABASE CONNECTION FAILED WITH ERROR - {}".format(e))

    if conn:
        return conn


def create_database(connection: Connection, sql_script: str) -> Cursor:

    cursor = connection.cursor()
    logger.success(" CREATED DATABASE CURSOR SUCCESSFULLY")

    try:
        with open(sql_script, "r") as file:
            cursor.executescript(file.read()) 
        logger.success(" CREATED DATABASE SCHEMA SUCCESSFULLY ")    

    except Error as e:
        logger.error(" DATABASE SCHEMA CREATION FAILED WITH ERROR {} ".format(e))

    return cursor    