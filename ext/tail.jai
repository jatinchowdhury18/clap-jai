CLAP_EXT_TAIL :: "clap.tail\0";

clap_plugin_tail_t :: struct {
    // Returns tail length in samples.
    // Any value greater or equal to INT32_MAX implies infinite tail.
    // [main-thread,audio-thread]
    get: (plugin: *clap_plugin_t) -> u32 #c_call;
}

clap_host_tail_t :: struct {
    // Tell the host that the tail has changed.
    // [audio-thread]
    changed: (host: *clap_host_t) -> void #c_call;
}
