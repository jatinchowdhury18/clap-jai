CLAP_EXT_LATENCY :: "clap.latency\0";

// The audio ports scan has to be done while the plugin is deactivated.
clap_plugin_latency_t :: struct {
    // Returns the plugin latency.
    // [main-thread]
    get: (plugin: *clap_plugin_t) -> u32 #c_call;
}

clap_host_latency_t :: struct {
    // Tell the host that the latency changed.
    // The latency is only allowed to change if the plugin is deactivated.
    // If the plugin is activated, call host->request_restart()
    // [main-thread]
    changed: (host: *clap_host_t) -> void #c_call;
}
