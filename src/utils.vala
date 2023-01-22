public string appDataDirPath() {
    return GLib.Path.build_path ("/", GLib.Environment.get_user_data_dir (), "quick-clip");
}

public string databasePath() {
    return GLib.Path.build_path("/", appDataDirPath(), "db.json");
}
