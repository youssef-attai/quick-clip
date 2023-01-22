
public class TextEntryRepository : Object {
    public string filename { get; construct; }

    public TextEntryRepository(string database_filename) {
        Object(
               filename: database_filename
        );
    }

    private Json.Node readDatabase() {
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

    private void writeDatabase(ref Json.Node db) {
        var gen = new Json.Generator();

        gen.set_root(db);

        try {
            gen.to_file(filename);
        } catch (Error e) {
            try {
                GLib.File.new_for_path(appDataDirPath()).make_directory_with_parents(null);
                gen.to_file(filename);
            } catch (Error e) {
                print("Error: %s\n", e.message);
            }
        }
    }

    public List<TextEntry> getAll() {
        var db = readDatabase();
        var allEntries = db.get_array();

        var results = new List<TextEntry> ();

        uint i = 0;
        foreach (unowned Json.Node entry in allEntries.get_elements()) {
            var obj = entry.get_object();
            var key = obj.get_members().nth_data(0);
            var textEntry = new TextEntry(key, obj.get_string_member(key));
            results.append(textEntry);
            i++;
        }

        return results;
    }

    public void add(TextEntry entry) {
        var db = readDatabase();
        var allEntries = db.get_array();

        var new_obj = new Json.Object();
        new_obj.set_string_member(entry.title, entry.text);

        allEntries.add_object_element(new_obj);

        writeDatabase(ref db);
    }

    public void remove(string title) {
        var db = readDatabase();
        var allEntries = db.get_array();

        uint i = 0;
        foreach (unowned Json.Node? entry in allEntries.get_elements()) {
            if (entry.get_object().get_members().nth_data(0) == title) {
                allEntries.remove_element(i);
                break;
            }
            i++;
        }

        writeDatabase(ref db);
    }
}