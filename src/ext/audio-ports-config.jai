/// @page Audio Ports Config
///
/// This extension provides a way for the plugin to describe possible port configurations, for
/// example mono, stereo, surround, ... and a way for the host to select a configuration.
///
/// After the plugin initialization, the host may scan the list of configurations and eventually
/// select one that fits the plugin context. The host can only select a configuration if the plugin
/// is deactivated.
///
/// A configuration is a very simple description of the audio ports:
/// - it describes the main input and output ports
/// - it has a name that can be displayed to the user
///
/// The idea behind the configurations, is to let the user choose one via a menu.
///
/// Plugins with very complex configuration possibilities should let the user configure the ports
/// from the plugin GUI, and call @ref clap_host_audio_ports.rescan(CLAP_AUDIO_PORTS_RESCAN_ALL).
///
/// To inquire the exact bus layout, the plugin implements the clap_plugin_audio_ports_config_info_t
/// extension where all busses can be retrieved in the same way as in the audio-port extension.

CLAP_EXT_AUDIO_PORTS_CONFIG :: "clap.audio-ports-config\0";
CLAP_EXT_AUDIO_PORTS_CONFIG_INFO :: "clap.audio-ports-config-info/draft-0\0";

// Minimalistic description of ports configuration
clap_audio_ports_config_t :: struct {
    id: clap_id;
    name: [CLAP_NAME_SIZE] char;

    input_port_count: u32;
    output_port_count: u32;

    // main input info
    has_main_input: bool;
    main_input_channel_count: u32;
    main_input_port_type: *char;

    // main output info
    has_main_output: bool;
    main_output_channel_count: u32;
    main_output_port_type: *char;
}

// The audio ports config scan has to be done while the plugin is deactivated.
clap_plugin_audio_ports_config_t :: struct {
    // gets the number of available configurations
    // [main-thread]
    count: (plugin: *clap_plugin_t) -> u32 #c_call;

    // gets information about a configuration
    // [main-thread]
    get: (plugin: *clap_plugin_t, index: u32, config: clap_audio_ports_config_t) -> bool #c_call;

    // selects the configuration designated by id
    // returns true if the configuration could be applied.
    // Once applied the host should scan again the audio ports.
    // [main-thread,plugin-deactivated]
    select: (plugin: *clap_plugin_t, config_id: clap_id) -> bool #c_call;
}

// Extended config info
clap_plugin_audio_ports_config_info_t :: struct {
    // Gets the id of the currently selected config, or CLAP_INVALID_ID if the current port
    // layout isn't part of the config list.
    //
    // [main-thread]
    current_config: (plugin: clap_plugin_t) -> clap_id #c_call;

    // Get info about about an audio port, for a given config_id.
    // This is analogous to clap_plugin_audio_ports.get().
    // [main-thread]
    get: (plugin: *clap_plugin_t, config_id: clap_id, port_index: u32, is_input: bool, info: *clap_audio_port_info_t) -> bool #c_call;
}

clap_host_audio_ports_config_t :: struct {
    // Rescan the full list of configs.
    // [main-thread]
    rescan: (host: *clap_host_t) -> void #c_call;
}
