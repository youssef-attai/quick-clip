import sys
from functools import partial

from PySide6.QtGui import QAction
from PySide6.QtWidgets import QSystemTrayIcon, QMenu

import res.strings
from app import App
from repository import Repository

try:
    # Only exists on Windows.
    from ctypes import windll

    windll.shell32.SetCurrentProcessExplicitAppUserModelID('com.attai.youssef.quickclipboard')
except ImportError:
    pass

if __name__ == '__main__':
    repository = Repository()
    app = App(sys.argv, repository)

    tray_icon = QSystemTrayIcon(app.icon)

    if tray_icon.isSystemTrayAvailable():
        # menu = QMenu()
        #
        # new_text_action = QAction("Add new text")
        # new_text_action.triggered.connect(lambda: app.add_new_text())
        #
        # quit_action = QAction("Quit")
        # quit_action.triggered.connect(lambda: sys.exit())
        #
        # menu.clear()
        #
        # texts = repository.get_all_texts()
        # actions = []
        #
        # for item in texts:
        #     action = menu.addAction(item.title)
        #     action.triggered.connect(partial(lambda tc: clipboard.setText(tc), item.content))
        #
        # menu.addActions(actions)
        # menu.addSeparator()
        #
        # menu.addAction(new_text_action)
        # menu.addAction(quit_action)

        app.recreate_menu()

        tray_icon.setContextMenu(app.menu)
        tray_icon.setVisible(True)
        tray_icon.setToolTip(res.strings.APP_NAME)

    sys.exit(app.exec())
