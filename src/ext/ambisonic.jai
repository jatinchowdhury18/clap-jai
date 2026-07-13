// This extension can be used to specify the channel mapping used by the plugin.
CLAP_EXT_AMBISONIC :: "clap.ambisonic/3\0";

// The latest draft is 100% compatible.
// This compat ID may be removed in 2026.
CLAP_EXT_AMBISONIC_COMPAT :: "clap.ambisonic.draft/3\0";

CLAP_PORT_AMBISONIC :: "ambisonic\0";

clap_ambisonic_ordering :: enum u32 {
    // FuMa channel ordering
    CLAP_AMBISONIC_ORDERING_FUMA :: 0;

    // ACN channel ordering
    CLAP_AMBISONIC_ORDERING_ACN :: 1;
}

clap_ambisonic_normalization :: enum u32 {
    CLAP_AMBISONIC_NORMALIZATION_MAXN :: 0;
    CLAP_AMBISONIC_NORMALIZATION_SN3D :: 1;
    CLAP_AMBISONIC_NORMALIZATION_N3D :: 2;
    CLAP_AMBISONIC_NORMALIZATION_SN2D :: 3;
    CLAP_AMBISONIC_NORMALIZATION_N2D :: 4;
}

clap_ambisonic_config_t :: struct {
    ordering: u32;      // see clap_ambisonic_ordering
    normalization: u32; // see clap_ambisonic_normalization
}

clap_plugin_ambisonic_t :: struct {
    // Returns true if the given configuration is supported.
    // [main-thread]
    is_config_supported: (plugin: *clap_plugin_t, config: *clap_ambisonic_config_t) -> bool #c_call;

    // Returns true on success
    // [main-thread]
    get_config: (plugin: *clap_plugin_t, is_input: bool, port_index: u32, config: *clap_ambisonic_config_t) -> bool #c_call;
}

clap_host_ambisonic_t :: struct {
    // Informs the host that the info has changed.
    // The info can only change when the plugin is de-activated.
    // [main-thread]
    changed: (host: *clap_host_t) -> void #c_call;
}
