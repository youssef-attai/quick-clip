public static int main(string[] args) {
    Gtk.init(ref args);

    var repo = new TextEntryRepository(databasePath());

    var indicator = new AppIndicator.Indicator("quick-clip", "quick-clip", AppIndicator.IndicatorCategory.APPLICATION_STATUS);
    indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE);

    var menu = new Gtk.Menu();

    foreach (TextEntry te in repo.getAll()) {
        var menuItem = new Gtk.MenuItem.with_label(te.title);
        menuItem.activate.connect(() => {
            Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD).set_text(te.text, -1);
        });
        menu.append(menuItem);
    }

    menu.append(new Gtk.SeparatorMenuItem());

    var editItem = new Gtk.MenuItem.with_label("Edit or delete");
    editItem.activate.connect(() => {});
    menu.append(editItem);

    var quitItem = new Gtk.MenuItem.with_label("Quit");
    quitItem.activate.connect(Gtk.main_quit);
    menu.append(quitItem);

    menu.show_all();
    indicator.set_menu(menu);

    Gtk.main();

    return 0;
}