import sqlite3

import res.strings
from model.text import Text


class TextRepository:
    def __init__(self) -> None:
        self.connection = sqlite3.connect(res.strings.DATABASE_PATH)
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
