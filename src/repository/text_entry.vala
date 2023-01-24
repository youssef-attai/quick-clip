public class QuickClip.TextEntryRepository : Object {
    public string filename { get; construct; }

    public TextEntryRepository(string database_filename) {
        Object(
               filename: database_filename
        );
    }

    private Json.Node read_database() {
        var parser = new Json.Parser();

        Json.Node db;

        try {
            parser.load_from_file(filename);
            db = parser.get_root();
        } catch (Error e) {
            db = new Json.Node(Json.NodeType.ARRAY);
            db.set_array(new Json.Array());
        }

        return db;
    }

    private void write_database(ref Json.Node db) {
        var gen = new Json.Generator();

        gen.set_root(db);

        try {
            gen.to_file(filename);
        } catch (Error e) {
            try {
                GLib.File.new_for_path(get_app_data_dir()).make_directory_with_parents(null);
                gen.to_file(filename);
            } catch (Error e) {
                print("Error: %s\n", e.message);
            }
        }
    }

    public List<TextEntry> get_all() {
        var db = read_database();
        var all_text_entries = db.get_array();

        var results = new List<TextEntry> ();

        uint i = 0;
        foreach (unowned Json.Node entry in all_text_entries.get_elements()) {
            var obj = entry.get_object();
            var key = obj.get_members().nth_data(0);
            var text_entry = new TextEntry(key, obj.get_string_member(key));
            results.append(text_entry);
            i++;
        }

        return results;
    }

    public void add(TextEntry entry) {
        var db = read_database();
        var all_entries = db.get_array();

        var new_obj = new Json.Object();
        new_obj.set_string_member(entry.title, entry.text);

        all_entries.add_object_element(new_obj);

        write_database(ref db);
    }

    public void remove(string title) {
        var db = read_database();
        var all_entries = db.get_array();

        uint i = 0;
        foreach (unowned Json.Node? entry in all_entries.get_elements()) {
            if (entry.get_object().get_members().nth_data(0) == title) {
                all_entries.remove_element(i);
                break;
            }
            i++;
        }

        write_database(ref db);
    }
}