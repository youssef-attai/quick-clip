executable(
    meson.project_name(),

    'main.vala',
    'utils.vala',

    'widget/new_text_entry.vala',
    'widget/edit_or_delete.vala',
    'widget/list_row.vala',

    'component/app_indicator.vala',

    'repository/text_entry.vala',
    
    'model/text_entry.vala',

    dependencies: [
        dependency('gtk+-3.0'),
        dependency('ayatana-appindicator3-0.1'),
        dependency('json-glib-1.0')
    ],

    install: true
)