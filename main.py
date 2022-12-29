import sys

from PySide6.QtWidgets import QSystemTrayIcon

import res.strings
from components.app import App
from components.database_connection import DatabaseConnection
from repository.text.text_repository import TextRepository

try:
    # Only exists on Windows.
    from ctypes import windll

    windll.shell32.SetCurrentProcessExplicitAppUserModelID(res.strings.APP_ID)
except ImportError:
    pass

if __name__ == '__main__':
    db = DatabaseConnection("texts.db")
    text_repo = TextRepository(db)
    app = App(sys.argv, text_repo)

    tray_icon = QSystemTrayIcon(app.icon)

    if tray_icon.isSystemTrayAvailable():
        app.recreate_menu()
        tray_icon.setContextMenu(app.menu)
        tray_icon.setVisible(True)
        tray_icon.setToolTip(res.strings.APP_NAME)

    sys.exit(app.exec())
