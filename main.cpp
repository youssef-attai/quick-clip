#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSystemTrayIcon>
#include <QMenu>
#include <filesystem>
#include <pwd.h>
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

    QSystemTrayIcon trayIcon(&app);
    trayIcon.setContextMenu(&menu);
    trayIcon.setIcon(icon);
    trayIcon.setVisible(true);

    app.refreshMenu();

    return QApplication::exec();
}

QString homeDir() {
    struct passwd *pw = getpwuid(getuid());
    const char *homedir = pw->pw_dir;
    return {homedir};
}

QString appDataDir() {
    return homeDir() + "/.local/share/quickclipboard/";
}

QString pathInAppDataDir(const QString &filename) {
    return appDataDir() + filename;
}