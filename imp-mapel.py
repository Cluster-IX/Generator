#!/bin/env python

import csv
import logging
import multiprocessing as mp

from contextlib import contextmanager
from pathlib import Path
from typing import Dict
from mysql.connector import MySQLConnection
from mysql.connector.cursor import MySQLCursor

import mysql.connector


logging.basicConfig(level=logging.DEBUG)

config = {
    "host": "localhost",
    "username": "root",
    "password": "",
    "database": "CBT_JATIM",
}


@contextmanager
def mysql_connect(connection_config: Dict) -> MySQLConnection:
    conn: MySQLConnection = mysql.connector.connect(**connection_config)
    logging.info(
        "Connected to database '%s' at '%s'",
        connection_config["database"],
        connection_config["host"],
    )
    yield conn

    logging.info("Closing connection to server '%s'", connection_config["host"])
    conn.close()


@contextmanager
def mysql_cursor(conn: MySQLConnection) -> MySQLCursor:
    cur: MySQLCursor = conn.cursor()
    yield cur

    logging.info("Closing cursor")
    cur.close()


insert_sql = "INSERT INTO Mata_Pelajaran (nama) VALUES (%s)"
def worker(rows):
    with mysql_connect(config) as conn:
        with mysql_cursor(conn) as cursor:
            logging.info("Processing batch")
            cursor.executemany(insert_sql, rows)
            conn.commit()


def get_chunks(batch_size: int, source_file: Path):
    with open(source_file, "r") as f:
        csv_reader = csv.reader(f, delimiter=",")
        next(csv_reader, None)
        batch_data = []
        batch_count = 0
        for row in csv_reader:
            # batch_data.append([v if v != '' else None for v in row])
            batch_data.append(row)
            batch_count += 1
            if batch_count % batch_size == 0:
                yield batch_data
                batch_data = []
        if batch_data:
            yield batch_data


def main():
    batch_size = 1
    source_file = Path("./csv/mapel.csv")
    chunk_gen = get_chunks(batch_size, source_file)

    pool = mp.Pool(mp.cpu_count() - 1)
    results = pool.imap(worker, chunk_gen)
    pool.close()
    pool.join()


if __name__ == "__main__":
    main()
