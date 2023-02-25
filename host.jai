clap_host_t :: struct {
    clap_version: clap_version_t; // initialized to CLAP_VERSION

    host_data: *void; // reserved pointer for the host

    // name and version are mandatory.
    // **These should be treated as const**
    name: *char;    // eg: "Bitwig Studio"
    vendor: *char;  // eg: "Bitwig GmbH"
    url: *char;     // eg: "https://bitwig.com"
    version: *char; // eg: "4.3", see plugin.h for advice on how to format the version

    // Query an extension.
    // The returned pointer is owned by the host.
    // It is forbidden to call it before plugin->init().
    // You can call it within plugin->init() call, and after.
    // [thread-safe]
    Func_get_extension :: #type (host: *clap_host_t, extension_id: *char) -> *void #c_call;
    get_extension: Func_get_extension;
 
    // Request the host to deactivate and then reactivate the plugin.
    // The operation may be delayed by the host.
    // [thread-safe]
    Func_request_restart :: #type (host: *clap_host_t) -> void #c_call;
    request_restart: Func_request_restart;
 
    // Request the host to activate and start processing the plugin.
    // This is useful if you have external IO and need to wake up the plugin from "sleep".
    // [thread-safe]
    Func_request_process :: #type (host: *clap_host_t) -> void #c_call;
    request_process: Func_request_process;
 
    // Request the host to schedule a call to plugin->on_main_thread(plugin) on the main thread.
    // [thread-safe]
    Func_request_callback :: #type (host: *clap_host_t) -> void;
    request_callback: Func_request_callback;
}
