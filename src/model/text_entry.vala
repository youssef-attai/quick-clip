public class TextEntry : Object {
    public string title { get; construct; }
    public string text { get; construct; }

    public TextEntry(string p_title, string p_text) {
        Object(
               title: p_title,
               text: p_text
        );
    }
}
