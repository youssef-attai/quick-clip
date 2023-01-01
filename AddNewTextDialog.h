#pragma once

#include <QDialog>
#include <QVBoxLayout>
#include <QLineEdit>

class AddNewTextDialog : public QDialog {
public:
    AddNewTextDialog();

    QString getTitle();

    QString getContent();

    void reset();

private:
    QVBoxLayout *layout;
    QLineEdit *titleLineEdit;
    QLineEdit *contentLineEdit;
};
