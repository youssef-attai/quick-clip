#pragma once

#include <QString>

struct Text {
    QString title, content;

    Text(QString _title, QString _content) : title{_title}, content{_content} {}
};