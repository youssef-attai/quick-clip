public static int main(string[] args) {
    Gtk.init(ref args);

    var repo = new TextEntryRepository(databasePath());
    //  repo.add(new TextEntry("Name", "Youssef"));
    //  repo.add(new TextEntry("Password", "123"));
    foreach (unowned TextEntry te in repo.getAll()) {
        stdout.printf("TextEntry(title=%s, text=%s)\n", te.title, te.text);
    }

    Gtk.main();

    return 0;
}