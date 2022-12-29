import sys
from functools import partial

from PySide6.QtGui import QIcon
from PySide6.QtWidgets import QApplication, QMenu

import res
from components.add_new_text_dialog import AddNewTextDialog
from model.text import Text


class App(QApplication):
    def __init__(self, argv, repository):
        super().__init__(argv)
        self.text_repository = repository
        print(res.strings.ICON_PATH)
        self.icon = QIcon(res.strings.ICON_PATH)
        self.setWindowIcon(self.icon)
        self.setApplicationName(res.strings.APP_NAME)
        self.setQuitOnLastWindowClosed(False)
        self.menu = QMenu()

    def add_new_text(self):
        dialog = AddNewTextDialog()
        if dialog.exec():
            title = dialog.title.text()
            content = dialog.content.text()
            self.text_repository.add_new_text(Text(title, content))
            self.recreate_menu()
        else:
            pass

    def recreate_menu(self):
        self.menu.clear()

        texts = self.text_repository.get_all_texts()

        for text in texts:
            action = self.menu.addAction(text.title)
            action.triggered.connect(partial(lambda tc: self.clipboard().setText(tc), text.content))

        self.menu.addSeparator()

        new_text_action = self.menu.addAction("Add new text")
        new_text_action.triggered.connect(lambda: self.add_new_text())

        delete_text_menu = self.menu.addMenu("Delete text")

        for text in texts:
            action = delete_text_menu.addAction(text.title)
            action.triggered.connect(partial(lambda tt: self.remove_text(tt), text.title))

        quit_action = self.menu.addAction("Quit")
        quit_action.triggered.connect(lambda: sys.exit())

    def remove_text(self, title):
        self.text_repository.remove_text(title)
        self.recreate_menu()
