#pragma once

#include <QList>
#include <QSqlDatabase>
#include "Text.h"

class TextRepository {
private:
    QSqlDatabase *db;
public:
    explicit TextRepository(QSqlDatabase *_db) : db{_db} {}

    void createTextsTable();

    QList<Text> getAllTexts();

    void addNewText(const Text &text);

    void deleteText(const QString &title);
};

