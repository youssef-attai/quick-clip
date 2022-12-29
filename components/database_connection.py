import os
import sqlite3

import res.strings


class DatabaseConnection:
    def __init__(self, filename: str) -> None:
        self.__DATABASE_DIR = os.path.join(res.strings.APPDATA_DIR, filename)
        try:
            self.connection = sqlite3.connect(self.__DATABASE_DIR)
        except sqlite3.OperationalError:
            os.makedirs(res.strings.APPDATA_DIR)
            self.connection = sqlite3.connect(self.__DATABASE_DIR)
        self.cursor = self.connection.cursor()

    def execute(self, query, params=None):
        if params is None:
            self.cursor.execute(query)
        else:
            self.cursor.execute(query, params)
        self.connection.commit()

    def select(self, query):
        self.cursor.execute(query)
        return self.cursor.fetchall()
