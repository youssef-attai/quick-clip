#include "App.h"

App::App(int &argc, char **argv, TextRepository *_textRepository)
        : QApplication(argc, argv),
          textRepository{_textRepository},
          addNewTextDialog{new AddNewTextDialog()},
          deleteMenu{new QMenu("Delete text")} {
    textRepository->createTextsTable();
}

void App::copyText(const QString &text) {
    QApplication::clipboard()->setText(text);
}

void App::refreshMenu() {
    menu->clear();
    deleteMenu->clear();

    QAction *action, *deleteAction;

    for (const Text &text: textRepository->getAllTexts()) {
        action = menu->addAction(text.title);
        connect(action, &QAction::triggered, [text]() {
            App::copyText(text.content);
        });
        deleteAction = deleteMenu->addAction(text.title);
        connect(deleteAction, &QAction::triggered, [this, text]() {
            deleteText(text.title);
        });
    }

    menu->addSeparator();

    action = menu->addAction("Add new text");
    connect(action, &QAction::triggered, [this]() {
        addNewText();
    });

    menu->addMenu(deleteMenu);

    action = menu->addAction("Quit");
    connect(action, &QAction::triggered, this, &App::quit);
}

void App::addNewText() {
    bool ok = addNewTextDialog->exec();
    if (ok) {
        textRepository->addNewText(Text(addNewTextDialog->getTitle(), addNewTextDialog->getContent()));
        refreshMenu();
        addNewTextDialog->reset();
    }
}

void App::setMenu(QMenu *_menu) {
    menu = _menu;
}

void App::deleteText(const QString &title) {
    textRepository->deleteText(title);
    refreshMenu();
}
