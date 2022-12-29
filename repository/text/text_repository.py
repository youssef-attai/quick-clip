from components.database_connection import DatabaseConnection
from model.text import Text
from repository.text import query


class TextRepository:
    def __init__(self, db: DatabaseConnection):
        self.db = db

        self.create_table_texts()

    def create_table_texts(self) -> None:
        self.db.execute(query.CREATE_TABLE())

    def add_new_text(self, new_text: Text) -> None:
        self.db.execute(query.INSERT(), new_text.to_tuple())

    def get_all_texts(self) -> list[Text]:
        texts = self.db.select(query.SELECT_ALL())
        return [Text.from_tuple(t) for t in texts]

    def remove_text(self, title: str) -> None:
        self.db.execute(query.DELETE(), (title,))
