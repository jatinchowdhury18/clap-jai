/// @page Audio Ports
///
/// This extension provides a way for the plugin to describe its current audio ports.
///
/// If the plugin does not implement this extension, it won't have audio ports.
///
/// 32 bits support is required for both host and plugins. 64 bits audio is optional.
///
/// The plugin is only allowed to change its ports configuration while it is deactivated.

CLAP_EXT_AUDIO_PORTS :: "clap.audio-ports\0";
CLAP_PORT_MONO :: "mono\0";
CLAP_PORT_STEREO :: "stereo\0";

// This port is the main audio input or output.
// There can be only one main input and main output.
// Main port must be at index 0.
CLAP_AUDIO_PORT_IS_MAIN : u32 : 1 << 0;

// This port can be used with 64 bits audio
CLAP_AUDIO_PORT_SUPPORTS_64BITS : u32 : 1 << 1;

// 64 bits audio is preferred with this port
CLAP_AUDIO_PORT_PREFERS_64BITS : u32 : 1 << 2;

// This port must be used with the same sample size as all the other ports which have this flag.
// In other words if all ports have this flag then the plugin may either be used entirely with
// 64 bits audio or 32 bits audio, but it can't be mixed.
CLAP_AUDIO_PORT_REQUIRES_COMMON_SAMPLE_SIZE : u32 : 1 << 3;

clap_audio_port_info_t :: struct {
    // id identifies a port and must be stable.
    // id may overlap between input and output ports.
    id: clap_id;
    name: [CLAP_NAME_SIZE] char; // displayable name

    flags: u32;
    channel_count: u32;

    // If null or empty then it is unspecified (arbitrary audio).
    // This filed can be compared against:
    // - CLAP_PORT_MONO
    // - CLAP_PORT_STEREO
    // - CLAP_PORT_SURROUND (defined in the surround extension)
    // - CLAP_PORT_AMBISONIC (defined in the ambisonic extension)
    // - CLAP_PORT_CV (defined in the cv extension)
    //
    // An extension can provide its own port type and way to inspect the channels.
    port_type: *char;

    // in-place processing: allow the host to use the same buffer for input and output
    // if supported set the pair port id.
    // if not supported set to CLAP_INVALID_ID
    in_place_pair: clap_id;
}

// The audio ports scan has to be done while the plugin is deactivated.
clap_plugin_audio_ports_t :: struct {
    // number of ports, for either input or output
    // [main-thread]
    count: (plugin: *clap_plugin_t, is_input: bool) -> u32 #c_call;

    // get info about about an audio port.
    // [main-thread]
    get: (plugin: *clap_plugin_t, index: u32, is_input: bool, info: *clap_audio_port_info_t) -> bool #c_call;   
}

// The ports name did change, the host can scan them right away.
CLAP_AUDIO_PORTS_RESCAN_NAMES : u32 : 1 << 0;

// [!active] The flags did change
CLAP_AUDIO_PORTS_RESCAN_FLAGS : u32 : 1 << 1;

// [!active] The channel_count did change
CLAP_AUDIO_PORTS_RESCAN_CHANNEL_COUNT : u32 : 1 << 2;

// [!active] The port type did change
CLAP_AUDIO_PORTS_RESCAN_PORT_TYPE : u32 : 1 << 3;

// [!active] The in-place pair did change, this requires.
CLAP_AUDIO_PORTS_RESCAN_IN_PLACE_PAIR : u32 : 1 << 4;

// [!active] The list of ports have changed: entries have been removed/added.
CLAP_AUDIO_PORTS_RESCAN_LIST : u32 : 1 << 5;

clap_host_audio_ports_t :: struct {
    // Checks if the host allows a plugin to change a given aspect of the audio ports definition.
    // [main-thread]
    is_rescan_flag_supported: (host: *clap_host_t, flag: u32) -> bool #c_call;

    // Rescan the full list of audio ports according to the flags.
    // It is illegal to ask the host to rescan with a flag that is not supported.
    // Certain flags require the plugin to be de-activated.
    // [main-thread]
    rescan: (host: *clap_host_t, flags: u32) -> void #c_call;
}
