import os
import sqlite3

import res.strings
from model.text import Text


class TextRepository:
    def __init__(self) -> None:
        try:
            self.connection = sqlite3.connect(res.strings.DATABASE_DIR)
        except sqlite3.OperationalError:
            os.makedirs(res.strings.APPDATA_DIR)
            self.connection = sqlite3.connect(res.strings.DATABASE_DIR)
        self.cursor = self.connection.cursor()

        try:
            self.create_table_texts()
        except sqlite3.OperationalError:
            pass

    def create_table_texts(self) -> None:
        self.cursor.execute("""CREATE TABLE texts (title TEXT PRIMARY KEY, content TEXT)""")
        self.connection.commit()

    def add_new_text(self, new_text: Text) -> None:
        self.cursor.execute("""INSERT INTO texts(title, content) VALUES (?, ?)""", new_text.to_tuple())
        self.connection.commit()

    def get_all_texts(self) -> list[Text]:
        self.cursor.execute("""SELECT * FROM texts""")
        texts = self.cursor.fetchall()
        return [Text.from_tuple(t) for t in texts]

    def remove_text(self, title: str) -> None:
        self.cursor.execute("""DELETE FROM texts WHERE title=?""", (title,))
        self.connection.commit()
