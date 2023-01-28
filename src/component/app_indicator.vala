public class QuickClip.Indicator : Object {
    private AppIndicator.Indicator indicator;
    private Gtk.Menu menu;
    private QuickClip.TextEntryRepository repo;

    public Indicator(ref QuickClip.TextEntryRepository text_rentry_repo) {
        repo = text_rentry_repo;

        indicator = new AppIndicator.Indicator("quick-clip", "quick-clip", AppIndicator.IndicatorCategory.APPLICATION_STATUS);
        indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE);

        menu = new Gtk.Menu();
        indicator.set_menu(menu);

        reload_menu_items();
    }

    public void reload_menu_items() {
        // Remove all menu items
        menu.hide();
        menu.foreach((menu_item) => {
            menu.remove(menu_item);
        });

        // Add a menu item for each text entry
        foreach (TextEntry text_entry in repo.get_all()) {
            var menu_item = new Gtk.MenuItem.with_label(text_entry.title);
            menu_item.activate.connect(() => {
                // Each menu item copies the text associated with it to the clipboard
                Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD).set_text(text_entry.text, -1);
            });
            menu.append(menu_item);
        }
        menu.append(new Gtk.SeparatorMenuItem());

        // Add the edit text entries menu item
        var add_new_text_item = new Gtk.MenuItem.with_label("Add new text");
        add_new_text_item.activate.connect(() => {
            var dialog = new NewTextEntry();

            var response = dialog.run();

            if (response == Gtk.ResponseType.OK) {
                repo.add(new TextEntry(dialog.title_entry.text, dialog.text_entry.text));
                reload_menu_items();
            } else if (response == Gtk.ResponseType.DELETE_EVENT) {
            }

            dialog.destroy();
        });
        menu.append(add_new_text_item);

        // Add the quit menu item
        var edit_item = new Gtk.MenuItem.with_label("Edit or delete text");
        edit_item.activate.connect(() => {
            var dialog = new EditOrDelete(ref repo);

            dialog.run();

            reload_menu_items();

            dialog.destroy();
        });
        menu.append(edit_item);

        // Add the quit menu item
        var quit_item = new Gtk.MenuItem.with_label("Quit");
        quit_item.activate.connect(Gtk.main_quit);
        menu.append(quit_item);

        // Show menu and all submenus
        menu.show_all();
    }
}