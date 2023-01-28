public class QuickClip.TextEntryListRow : Gtk.ListBoxRow {
    public Gtk.Button text_entry_title_btn ;
    public Gtk.Button delete_btn ;

    public TextEntryListRow(TextEntry text_entry) {
        selectable = false;
        var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        text_entry_title_btn = new Gtk.Button.with_label (text_entry.title);
        text_entry_title_btn.hexpand = true;
        delete_btn = new Gtk.Button.from_icon_name ("list-remove");
        box.add (text_entry_title_btn);
        box.add(delete_btn);
        add (box);
    }

}