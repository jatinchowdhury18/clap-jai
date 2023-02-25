clap_plugin_descriptor_t :: struct {
    clap_version: clap_version_t; // initialized to CLAP_VERSION

    // Mandatory fields must be set and must not be blank.
    // Otherwise the fields can be null or blank, though it is safer to make them blank.
    //
    // Some indications regarding id and version
    // - id is an arbritrary string which should be unique to your plugin,
    //   we encourage you to use a reverse URI eg: "com.u-he.diva"
    // - version is an arbitrary string which describes a plugin,
    //   it is useful for the host to understand and be able to compare two different
    //   version strings, so here is a regex like expression which is likely to be
    //   understood by most hosts: MAJOR(.MINOR(.REVISION)?)?( (Alpha|Beta) XREV)?
    // **These should be treated as const**
    id: *char;          // eg: "com.u-he.diva", mandatory
    name: *char;        // eg: "Diva", mandatory
    vendor: *char;      // eg: "u-he"
    url: *char;         // eg: "https://u-he.com/products/diva/"
    manual_url: *char;  // eg: "https://dl.u-he.com/manuals/plugins/diva/Diva-user-guide.pdf"
    support_url: *char; // eg: "https://u-he.com/support/"
    version: *char;     // eg: "1.4.4"
    description: *char; // eg: "The spirit of analogue"

    // Arbitrary list of keywords.
    // They can be matched by the host indexer and used to classify the plugin.
    // The array of pointers must be null terminated.
    // For some standard features see plugin-features.h
    // **This should be treated as const**
    features: **char;
}

clap_plugin_t :: struct {
    // **This should be treated as const**
    desc: *clap_plugin_descriptor_t;

    plugin_data: *void; // reserved pointer for the plugin

    // Must be called after creating the plugin.
    // If init returns false, the host must destroy the plugin instance.
    // If init returns true, then the plugin is initialized and in the deactivated state.
    // [main-thread]
    Func_init :: #type (plugin: *clap_plugin_t) -> bool #c_call;
    init: Func_init;

    // Free the plugin and its resources.
    // It is required to deactivate the plugin prior to this call.
    // [main-thread & !active]
    Func_destroy :: #type (plugin: *clap_plugin_t) -> void #c_call;
    destroy: Func_destroy;

    // Activate and deactivate the plugin.
    // In this call the plugin may allocate memory and prepare everything needed for the process
    // call. The process's sample rate will be constant and process's frame count will included in
    // the [min, max] range, which is bounded by [1, INT32_MAX].
    // Once activated the latency and port configuration must remain constant, until deactivation.
    //
    // [main-thread & !active_state]
    Func_activate :: #type (plugin: *clap_plugin_t, sample_rate: float64, min_frames_count: u32, max_frames_count: u32) -> bool #c_call;
    activate: Func_activate;

    // [main-thread & active_state]
    Func_deactivate :: #type (plugin: *clap_plugin_t) -> void #c_call;
    deactivate: Func_deactivate;

    // Call start processing before processing.
    // [audio-thread & active_state & !processing_state]
    Func_start_processing :: #type (plugin: *clap_plugin_t) -> bool #c_call;
    start_processing: Func_start_processing;

    // Call stop processing before sending the plugin to sleep.
    // [audio-thread & active_state & processing_state]
    Func_stop_processing :: #type (plugin: *clap_plugin_t) -> void #c_call;
    stop_processing: Func_stop_processing;

    // - Clears all buffers, performs a full reset of the processing state (filters, oscillators,
    //   enveloppes, lfo, ...) and kills all voices.
    // - The parameter's value remain unchanged.
    // - clap_process.steady_time may jump backward.
    //
    // [audio-thread & active_state]
    Func_reset :: #type (plugin: *clap_plugin_t) -> void #c_call;
    reset: Func_reset;

    // process audio, events, ...
    // All the pointers coming from clap_process_t and its nested attributes,
    // are valid until process() returns.
    // [audio-thread & active_state & processing_state]
    Func_process :: #type (plugin: *clap_plugin_t, process: *clap_process_t) -> clap_process_status #c_call;
    process: Func_process;

    // Query an extension.
    // The returned pointer is owned by the plugin.
    // It is forbidden to call it before plugin->init().
    // You can call it within plugin->init() call, and after.
    // [thread-safe]
    Func_get_extension :: #type (plugin: *clap_plugin_t, id: *char) -> *void #c_call;
    get_extension: Func_get_extension;

    // Called by the host on the main thread in response to a previous call to:
    //   host->request_callback(host);
    // [main-thread]
    Func_on_main_thread :: #type (plugin: *clap_plugin_t) -> void #c_call;
    on_main_thread: Func_on_main_thread;
};