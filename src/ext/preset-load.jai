CLAP_EXT_PRESET_LOAD :: "clap.preset-load/2\0";

// The latest draft is 100% compatible.
// This compat ID may be removed in 2026.
CLAP_EXT_PRESET_LOAD_COMPAT :: "clap.preset-load.draft/2\0";

clap_plugin_preset_load_t :: struct {
    // Loads a preset in the plugin native preset file format from a location.
    // The preset discovery provider defines the location and load_key to be passed to this function.
    // Returns true on success.
    // [main-thread]
    from_location: (plugin: *clap_plugin_t, location_kind: u32, location: *char, load_key: *char) -> bool #c_call;
}

clap_host_preset_load_t :: struct {
    // Called if clap_plugin_preset_load.from_location() failed.
    // os_error: the operating system error, if applicable. If not applicable set it to a non-error
    // value, eg: 0 on unix and Windows.
    //
    // [main-thread]
    on_error: (host: *clap_host_t, location_kind: u32, location: *char, load_key: *char, os_error: s32, msg: *char) -> void #c_call;

    // Informs the host that the following preset has been loaded.
    // This contributes to keep in sync the host preset browser and plugin preset browser.
    // If the preset was loaded from a container file, then the load_key must be set, otherwise it
    // must be null.
    //
    // [main-thread]
    loaded: (host: *clap_host_t, location_kind: u32, location: *char, load_key: *char) -> void #c_call;
}
