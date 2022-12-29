def CREATE_TABLE():
    return """CREATE TABLE IF NOT EXISTS texts (title TEXT PRIMARY KEY, content TEXT)"""


def INSERT():
    return """INSERT INTO texts(title, content) VALUES (?, ?)"""


def SELECT_ALL():
    return """SELECT * FROM texts"""


def DELETE():
    return """DELETE FROM texts WHERE title=?"""
