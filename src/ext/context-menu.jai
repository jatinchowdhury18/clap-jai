// This extension lets the host and plugin exchange menu items and let the plugin ask the host to
// show its context menu.

CLAP_EXT_CONTEXT_MENU :: "clap.context-menu/1\0";

// The latest draft is 100% compatible.
// This compat ID may be removed in 2026.
CLAP_EXT_CONTEXT_MENU_COMPAT :: "clap.context-menu.draft/0\0";

// There can be different target kind for a context menu
CLAP_CONTEXT_MENU_TARGET_KIND_GLOBAL : u32 : 0;
CLAP_CONTEXT_MENU_TARGET_KIND_PARAM : u32 : 1;

// Describes the context menu target
clap_context_menu_target_t :: struct {
    kind: u32;
    id: clap_id;
}

clap_context_menu_item_kind_t :: #type u32;

// Adds a clickable menu entry.
// data: *clap_context_menu_entry_t
CLAP_CONTEXT_MENU_ITEM_ENTRY : clap_context_menu_item_kind_t : 0;

// Adds a clickable menu entry which will feature both a checkmark and a label.
// data: *clap_context_menu_check_entry_t
CLAP_CONTEXT_MENU_ITEM_CHECK_ENTRY : clap_context_menu_item_kind_t : 1;

// Adds a separator line.
// data: null
CLAP_CONTEXT_MENU_ITEM_SEPARATOR : clap_context_menu_item_kind_t : 2;

// Starts a sub menu with the given label.
// data: *clap_context_menu_submenu_t
CLAP_CONTEXT_MENU_ITEM_BEGIN_SUBMENU : clap_context_menu_item_kind_t : 3;

// Ends the current sub menu.
// data: null
CLAP_CONTEXT_MENU_ITEM_END_SUBMENU : clap_context_menu_item_kind_t : 4;

// Adds a title entry
// data: *clap_context_menu_item_title_t
CLAP_CONTEXT_MENU_ITEM_TITLE : clap_context_menu_item_kind_t : 5;

clap_context_menu_entry_t :: struct {
    // text to be displayed
    label: *char;

    // if false, then the menu entry is greyed out and not clickable
    is_enabled: bool;
    action_id: clap_id;
}

clap_context_menu_check_entry_t :: struct {
    // text to be displayed
    label: *char;

    // if false, then the menu entry is greyed out and not clickable
    is_enabled: bool;

    // if true, then the menu entry will be displayed as checked
    is_checked: bool;
    action_id: clap_id;
}

clap_context_menu_item_title_t :: struct {
    // text to be displayed
    title: *char;

    // if false, then the menu entry is greyed out
    is_enabled: bool;
}

clap_context_menu_submenu_t :: struct {
    // text to be displayed
    label: *char;

    // if false, then the menu entry is greyed out and won't show submenu
    is_enabled: bool;
}

// Context menu builder.
// This object isn't thread-safe and must be used on the same thread as it was provided.
clap_context_menu_builder_t :: struct {
    ctx: *void;

    // Adds an entry to the menu.
    // item_data type is determined by item_kind.
    // Returns true on success.
    add_item: (builder: *clap_context_menu_builder_t, item_kind: clap_context_menu_item_kind_t, item_data: *void) -> bool #c_call;

    // Returns true if the menu builder supports the given item kind
    supports: (builder: *clap_context_menu_builder_t, item_kind: clap_context_menu_item_kind_t) -> bool #c_call;
}

clap_plugin_context_menu_t :: struct {
    // Insert plugin's menu items into the menu builder.
    // If target is null, assume global context.
    // Returns true on success.
    // [main-thread]
    populate: (plugin: *clap_plugin_t, target: *clap_context_menu_target_t, builder: *clap_context_menu_builder_t) -> bool #c_call;

    // Performs the given action, which was previously provided to the host via populate().
    // If target is null, assume global context.
    // Returns true on success.
    // [main-thread]
    perform: (plugin: *clap_plugin_t, target: *clap_context_menu_target_t, action_id: clap_id) -> bool #c_call;
}

clap_host_context_menu_t :: struct {
    // Insert host's menu items into the menu builder.
    // If target is null, assume global context.
    // Returns true on success.
    // [main-thread]
    populate: (host: *clap_host_t, target: *clap_context_menu_target_t, builder: *clap_context_menu_builder_t) -> bool #c_call;

    // Performs the given action, which was previously provided to the plugin via populate().
    // If target is null, assume global context.
    // Returns true on success.
    // [main-thread]
    perform: (host: *clap_host_t, target: *clap_context_menu_target_t, action_id: clap_id) -> bool #c_call;

    // Returns true if the host can display a popup menu for the plugin.
    // This may depend upon the current windowing system used to display the plugin, so the
    // return value is invalidated after creating the plugin window.
    // [main-thread]
    can_popup: (host: *clap_host_t) -> bool #c_call;

    // Shows the host popup menu for a given parameter.
    // If the plugin is using embedded GUI, then x and y are relative to the plugin's window,
    // otherwise they're absolute coordinate, and screen index might be set accordingly.
    // If target is null, assume global context.
    // Returns true on success.
    // [main-thread]
    popup: (host: *clap_host_t, target: *clap_context_menu_target_t, screen_index: s32, x: s32, y: s32) -> bool #c_call;
}
