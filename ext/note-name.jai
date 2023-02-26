CLAP_EXT_NOTE_NAME :: "clap.note-name\0";

clap_note_name_t :: struct {
    name: [CLAP_NAME_SIZE] char;
    port: s16;      // -1 for every port
    key: s16;       // -1 for every key
    channel: s16;   // -1 for every channel
}

clap_plugin_note_name_t :: struct {
    // Return the number of note names
    // [main-thread]
    count: (plugin: *clap_plugin_t) -> u32 #c_call;

    // Returns true on success and stores the result into note_name
    // [main-thread]
    get: (plugin: *clap_plugin_t, index: u32, note_name: *clap_note_name_t) -> bool #c_call;
}

clap_host_note_name_t :: struct {
    // Informs the host that the note names have changed.
    // [main-thread]
    changed: (host: *clap_host_t) -> void #c_call;
}
