public static int main(string[] args) {
    Gtk.init(ref args);

    var repo = new QuickClip.TextEntryRepository(get_database_dir());

    var indicator = new QuickClip.Indicator(ref repo);

    Gtk.main();

    return 0;
}