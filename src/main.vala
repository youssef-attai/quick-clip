public static int main(string[] args) {
    Gtk.init(ref args);

    var repo = new TextEntryRepository(get_database_dir());

    var indicator = new AppIndicator.Indicator("quick-clip", "quick-clip", AppIndicator.IndicatorCategory.APPLICATION_STATUS);
    indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE);

    var menu = new Gtk.Menu();

    foreach (TextEntry text_entry in repo.get_all()) {
        var menu_item = new Gtk.MenuItem.with_label(text_entry.title);
        menu_item.activate.connect(() => {
            Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD).set_text(text_entry.text, -1);
        });
        menu.append(menu_item);
    }

    menu.append(new Gtk.SeparatorMenuItem());

    var edit_item = new Gtk.MenuItem.with_label("Edit or delete");
    edit_item.activate.connect(() => {});
    menu.append(edit_item);

    var quit_ttem = new Gtk.MenuItem.with_label("Quit");
    quit_ttem.activate.connect(Gtk.main_quit);
    menu.append(quit_ttem);

    menu.show_all();
    indicator.set_menu(menu);

    Gtk.main();

    return 0;
}