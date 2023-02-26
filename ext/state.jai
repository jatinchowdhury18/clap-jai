CLAP_EXT_STATE :: "clap.state\0";

clap_plugin_state_t :: struct {
    // Saves the plugin state into stream.
    // Returns true if the state was correctly saved.
    // [main-thread]
    save: (plugin: *clap_plugin_t, stream: *clap_ostream_t) -> bool #c_call;

    // Loads the plugin state from stream.
    // Returns true if the state was correctly restored.
    // [main-thread]
    load: (plugin: *clap_plugin_t, stream: *clap_istream_t) -> bool #c_call;
}

clap_host_state_t :: struct {
    // Tell the host that the plugin state has changed and should be saved again.
    // If a parameter value changes, then it is implicit that the state is dirty.
    // [main-thread]
    mark_dirty: (host: *clap_host_t) -> void #c_call;
}
