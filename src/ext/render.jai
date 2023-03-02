CLAP_EXT_RENDER :: "clap.render\0";

clap_plugin_render_mode :: enum s32 {
    // Default setting, for "realtime" processing
    CLAP_RENDER_REALTIME :: 0;

    // For processing without realtime pressure
    // The plugin may use more expensive algorithms for higher sound quality.
    CLAP_RENDER_OFFLINE :: 1;
}

// The render extension is used to let the plugin know if it has "realtime"
// pressure to process.
//
// If this information does not influence your rendering code, then don't
// implement this extension.
clap_plugin_render_t :: struct {
    // Returns true if the plugin has an hard requirement to process in real-time.
    // This is especially useful for plugin acting as a proxy to an hardware device.
    // [main-thread]
    has_hard_realtime_requirement: (plugin: *clap_plugin_t) -> bool #c_call;

    // Returns true if the rendering mode could be applied.
    // [main-thread]
    set: (plugin: *clap_plugin_t, mode: clap_plugin_render_mode) -> bool #c_call;
}
