#include <QSqlQuery>
#include "TextRepository.h"


QList<Text> TextRepository::getAllTexts() {
    QList<Text> results;

    QSqlQuery selectQuery = db->exec("SELECT * FROM texts;");

    while (selectQuery.next())
        results.push_back(Text(selectQuery.value(0).toString(), selectQuery.value(1).toString()));
    
    return results;
}

void TextRepository::createTextsTable() {
    db->exec("CREATE TABLE IF NOT EXISTS texts (title TEXT PRIMARY KEY, content TEXT NOT NULL);");
}

void TextRepository::addNewText(const Text &text) {
    // FIXME: This is vulnerable to SQL injection
    QString query;
    QTextStream(&query) << "INSERT INTO texts VALUES ('" << text.title << "', '" << text.content << "');";
    db->exec(query);
}

void TextRepository::deleteText(const QString &title) {
    // FIXME: This is vulnerable to SQL injection
    QString query;
    QTextStream(&query) << "DELETE FROM texts WHERE title='" << title << "';";
    db->exec(query);
}
