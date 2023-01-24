public string get_app_data_dir() {
    return GLib.Path.build_path ("/", GLib.Environment.get_user_data_dir (), "quick-clip");
}

public string get_database_dir() {
    return GLib.Path.build_path("/", get_app_data_dir(), "db.json");
}
