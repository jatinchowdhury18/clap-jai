// Use it to retrieve const clap_plugin_factory_t* from
// clap_plugin_entry.get_factory()
CLAP_PLUGIN_FACTORY_ID :: "clap.plugin-factory";

// Every method must be thread-safe.
// It is very important to be able to scan the plugin as quickly as possible.
//
// The host may use clap_plugin_invalidation_factory to detect filesystem changes
// which may change the factory's content.
clap_plugin_factory_t :: struct {
    // Get the number of plugins available.
    // [thread-safe]
    Func_get_plugin_count :: #type (factory: *clap_plugin_factory_t) -> u32 #c_call;
    get_plugin_count: Func_get_plugin_count;

    // Retrieves a plugin descriptor by its index.
    // Returns null in case of error.
    // The descriptor must not be freed.
    // [thread-safe]
    Func_get_plugin_descriptor :: #type (factory: *clap_plugin_factory_t, index: u32) -> *clap_plugin_descriptor_t #c_call;
    get_plugin_descriptor: Func_get_plugin_descriptor;

    // Create a clap_plugin by its plugin_id.
    // The returned pointer must be freed by calling plugin->destroy(plugin);
    // The plugin is not allowed to use the host callbacks in the create method.
    // Returns null in case of error.
    // [thread-safe]
    Func_create_plugin :: #type (factory: *clap_plugin_factory_t, host: *clap_host_t, plugin_id: *char) -> *clap_plugin_t #c_call;
    create_plugin: Func_create_plugin;
}
