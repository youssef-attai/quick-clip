public static int main(string[] args) {
    Gtk.init(ref args);

    var repo = new TextEntryRepository(databasePath());
    var indicator = new AppIndicator.Indicator("quick-clip", "quick-clip", AppIndicator.IndicatorCategory.APPLICATION_STATUS);
    indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE);

    }

    Gtk.main();

    return 0;
}