#pragma once

#include <QApplication>
#include <QClipboard>
#include <QMenu>
#include "TextRepository.h"
#include "AddNewTextDialog.h"


class App : public QApplication {
Q_OBJECT

public:
    App(int &argc, char **argv, TextRepository *_textRepository);

    void refreshMenu();

    void addNewText();

    void deleteText(const QString &title);

    void setMenu(QMenu *_menu);


public slots:

    static void copyText(const QString &text);


private:
    TextRepository *textRepository{nullptr};
    QMenu *menu{nullptr};
    QMenu *deleteMenu{nullptr};
    AddNewTextDialog *addNewTextDialog{nullptr};
};
