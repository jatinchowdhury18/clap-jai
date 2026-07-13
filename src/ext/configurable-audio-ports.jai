// This extension lets the host configure the plugin's input and output audio ports.
// This is a "push" approach to audio ports configuration.

CLAP_EXT_CONFIGURABLE_AUDIO_PORTS :: "clap.configurable-audio-ports/1\0";

// The latest draft is 100% compatible.
// This compat ID may be removed in 2026.
CLAP_EXT_CONFIGURABLE_AUDIO_PORTS_COMPAT :: "clap.configurable-audio-ports.draft1\0";

clap_audio_port_configuration_request_t :: struct {
    // Identifies the port by is_input and port_index
    is_input: bool;
    port_index: u32;

    // The requested number of channels.
    channel_count: u32;

    // The port type, see audio-ports.h, clap_audio_port_info.port_type for interpretation.
    port_type: *char;

    // cast port_details according to port_type:
    // - CLAP_PORT_MONO: (discard)
    // - CLAP_PORT_STEREO: (discard)
    // - CLAP_PORT_SURROUND: const uint8_t *channel_map
    // - CLAP_PORT_AMBISONIC: const clap_ambisonic_config_t *info
    port_details: *void;
}

clap_plugin_configurable_audio_ports_t :: struct {
    // Returns true if the given configurations can be applied using apply_configuration().
    // [main-thread & !active]
    can_apply_configuration: (plugin: *clap_plugin_t, requests: *clap_audio_port_configuration_request_t, request_count: u32) -> bool #c_call;

    // Submit a bunch of configuration requests which will atomically be applied together,
    // or discarded together.
    //
    // Once the configuration is successfully applied, it isn't necessary for the plugin to call
    // clap_host_audio_ports->changed(); and it isn't necessary for the host to scan the
    // audio ports.
    //
    // Returns true if applied.
    // [main-thread & !active]
    apply_configuration: (plugin: *clap_plugin_t, requests: *clap_audio_port_configuration_request_t, request_count: u32) -> bool #c_call;
}
