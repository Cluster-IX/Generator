import mysql.connector

"""
Import database structure with relation
from SCHEMA_FILENAME .sql
"""

SCHEMA_FILENAME="./SCHEMA.sql"

config = {
    "host": "localhost",
    "username": "root",
    "password": "",
    "database": "CBT_JATIM",
}

def main():
    file = open(SCHEMA_FILENAME)
    sql = file.read()

    cnx = mysql.connector.connect(**config)

    cursor = cnx.cursor()
    cursor.execute(sql, multi=True)
    cnx.close()

if __name__ == "__main__":
    main()
