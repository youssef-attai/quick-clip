#include "AddNewTextDialog.h"

AddNewTextDialog::AddNewTextDialog() :
        layout{new QVBoxLayout(this)},
        titleLineEdit{new QLineEdit(this)},
        contentLineEdit{new QLineEdit(this)} {

    titleLineEdit->setPlaceholderText("Title");
    contentLineEdit->setPlaceholderText("Text");

    titleLineEdit->setFocus();
    connect(titleLineEdit, &QLineEdit::returnPressed, [this]() {
        contentLineEdit->setFocus();
    });

    connect(contentLineEdit, &QLineEdit::returnPressed, [this]() {
        accept();
    });

    layout->addWidget(titleLineEdit);
    layout->addWidget(contentLineEdit);

    setLayout(layout);
}

QString AddNewTextDialog::getTitle() {
    return titleLineEdit->text();
}

QString AddNewTextDialog::getContent() {
    return contentLineEdit->text();
}

void AddNewTextDialog::reset() {
    titleLineEdit->setFocus();
    titleLineEdit->setText("");
    contentLineEdit->setText("");
}
