public class EditOrDelete : Gtk.Dialog {
    public QuickClip.TextEntryRepository repo { get; construct; }
    private Gtk.ListBox list_box;

    public EditOrDelete(ref QuickClip.TextEntryRepository text_repo) {
        Object(
               repo: text_repo
        );
        title = "Edit or delete texts";

        list_box = new Gtk.ListBox();

        reload_text_entries();

        get_content_area().add(list_box);
        show_all();
    }

    private void reload_text_entries() {
        list_box.hide();
        list_box.foreach((row) => {
            list_box.remove(row);
        });

        foreach (TextEntry text_entry in repo.get_all()) {
            var row = new QuickClip.TextEntryListRow(text_entry);
            row.text_entry_title_btn.clicked.connect(() => {
                var dialog = new NewTextEntry(text_entry.title, text_entry.text);
                var response = dialog.run();

                if (response == Gtk.ResponseType.OK) {
                    repo.update(text_entry.title, dialog.title_entry.text, dialog.text_entry.text);

                    reload_text_entries();
                } else if (response == Gtk.ResponseType.DELETE_EVENT) {
                }

                dialog.destroy();
            });
            row.delete_btn.clicked.connect(() => {
                repo.remove(text_entry.title);
                reload_text_entries();
            });
            list_box.add(row);
        }
        list_box.show_all();
    }
}