public class NewTextEntry : Gtk.Dialog {
    public Gtk.Entry title_entry = new Gtk.Entry ();
    public Gtk.Entry text_entry = new Gtk.Entry ();

    public NewTextEntry (string p_title = "", string p_text = "") {
        title = "Add new text";

        title_entry.text = p_title;
        text_entry.text = p_text;

        get_content_area ().add (title_entry);
        get_content_area ().add (text_entry);

        title_entry.key_press_event.connect ((o, e) => {
            if (e.keyval == Gdk.Key.Return) {
                text_entry.grab_focus ();
            }
            return false;
        });

        text_entry.key_press_event.connect ((o, e) => {
            if (e.keyval == Gdk.Key.Return) {
                response (Gtk.ResponseType.OK);
                return true;
            }
            return false;
        });
 
        show_all ();
    }
}