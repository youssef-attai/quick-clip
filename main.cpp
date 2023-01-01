#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSystemTrayIcon>
#include <QMenu>
#include <filesystem>
#include <sstream>
#include <shlobj.h>
#include "App.h"


QString pathInAppDataDir(const QString &filename);

QString appDataDir();

QString homeDir();

int main(int argc, char *argv[]) {
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(pathInAppDataDir("quickclipboard.db"));
    db.open();

    if (!db.isOpen()) {
        std::filesystem::create_directories(std::filesystem::path(appDataDir().toStdString()));
        db.open();
    }

    if (!db.isOpen())return 1;

    TextRepository textRepository(&db);

    App app(argc, argv, &textRepository);
    App::setQuitOnLastWindowClosed(false);

    QIcon icon(":/imgs/clipboard.png");
    App::setWindowIcon(icon);
    
    QMenu menu;
    app.setMenu(&menu);

    QSystemTrayIcon trayIcon(icon, &app);
    trayIcon.setContextMenu(&menu);
    trayIcon.show();

    app.refreshMenu();

    return QApplication::exec();
}

std::string utf16ToUtf8(const std::wstring& utf16Str)
{
    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> conv;
    return conv.to_bytes(utf16Str);
}

QString homeDir() {
    // Fetch Local App Data folder path.
    wchar_t* localAppData = 0;
    SHGetKnownFolderPath(FOLDERID_LocalAppData, 0, nullptr, &localAppData);

    std::wstringstream ss;
    ss << localAppData;

    CoTaskMemFree(static_cast<void*>(localAppData));
    return {utf16ToUtf8(ss.str()).c_str()};
}

QString appDataDir() {
    qInfo() << homeDir();
    return homeDir() + "/quickclipboard/";
}

QString pathInAppDataDir(const QString &filename) {
    return appDataDir() + filename;
}
