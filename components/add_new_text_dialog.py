from PySide6.QtWidgets import QDialog, QVBoxLayout, QLineEdit

import res.strings


class AddNewTextDialog(QDialog):
    def __init__(self):
        super().__init__()

        self.setWindowTitle(res.strings.ADD_NEW_TEXT_DIALOG_TITE)

        self.layout = QVBoxLayout()

        self.title = QLineEdit()
        self.title.setFocus()

        self.content = QLineEdit()

        self.title.setPlaceholderText("Title")
        self.title.returnPressed.connect(lambda: self.content.setFocus())

        self.content.setPlaceholderText("Text")
        self.content.returnPressed.connect(self.accept)

        self.layout.addWidget(self.title)
        self.layout.addWidget(self.content)

        self.setLayout(self.layout)
