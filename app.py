import sys
from functools import partial

from PySide6.QtGui import QIcon, QAction
from PySide6.QtWidgets import QApplication, QMenu

import res
from add_new_text_dialog import AddNewTextDialog
from text import Text


class App(QApplication):
    def __init__(self, argv, repository):
        super().__init__(argv)
        self.repository = repository
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
            self.repository.add_new_text(Text(title, content))
            self.recreate_menu()
        else:
            pass

    def recreate_menu(self):
        self.menu.clear()

        texts = self.repository.get_all_texts()
        actions = []

        for item in texts:
            action = self.menu.addAction(item.title)
            action.triggered.connect(partial(lambda tc: self.clipboard().setText(tc), item.content))

        self.menu.addActions(actions)
        self.menu.addSeparator()

        new_text_action = self.menu.addAction("Add new text")
        new_text_action.triggered.connect(lambda: self.add_new_text())

        quit_action = self.menu.addAction("Quit")
        quit_action.triggered.connect(lambda: sys.exit())
