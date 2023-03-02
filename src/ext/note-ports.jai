/// @page Note Ports
///
/// This extension provides a way for the plugin to describe its current note ports.
/// If the plugin does not implement this extension, it won't have note input or output.
/// The plugin is only allowed to change its note ports configuration while it is deactivated.

CLAP_EXT_NOTE_PORTS :: "clap.note-ports\0";

clap_note_dialect :: enum u32 {
    // Uses clap_event_note and clap_event_note_expression.
    CLAP_NOTE_DIALECT_CLAP :: 1 << 0;

    // Uses clap_event_midi, no polyphonic expression
    CLAP_NOTE_DIALECT_MIDI :: 1 << 1;

    // Uses clap_event_midi, with polyphonic expression (MPE)
    CLAP_NOTE_DIALECT_MIDI_MPE :: 1 << 2;

    // Uses clap_event_midi2
    CLAP_NOTE_DIALECT_MIDI2 :: 1 << 3;
}

clap_note_port_info_t :: struct {
    // id identifies a port and must be stable.
    // id may overlap between input and output ports.
    id: clap_id;
    supported_dialects: u32;   // bitfield, see clap_note_dialect
    preferred_dialect: u32;    // one value of clap_note_dialect
    name: [CLAP_NAME_SIZE] char; // displayable name, i18n?
}

// The note ports scan has to be done while the plugin is deactivated.
clap_plugin_note_ports_t :: struct {
    // number of ports, for either input or output
    // [main-thread]
    count: (plugin: *clap_plugin_t, is_input: bool) -> u32 #c_call;

    // get info about about a note port.
    // [main-thread]
    get: (plugin: *clap_plugin_t, index: u32, is_input: bool, info: *clap_note_port_info_t) -> bool #c_call;
}

// The ports have changed, the host shall perform a full scan of the ports.
// This flag can only be used if the plugin is not active.
// If the plugin active, call host->request_restart() and then call rescan()
// when the host calls deactivate()
CLAP_NOTE_PORTS_RESCAN_ALL : u32 : 1 << 0;

// The ports name did change, the host can scan them right away.
CLAP_NOTE_PORTS_RESCAN_NAMES : u32 : 1 << 1;

clap_host_note_ports_t :: struct {
    // Query which dialects the host supports
    // [main-thread]
    supported_dialects: (host: *clap_host_t) -> u32 #c_call;

    // Rescan the full list of note ports according to the flags.
    // [main-thread]
    rescan: (host: *clap_host_t, flags: u32) -> void #c_call;
}
