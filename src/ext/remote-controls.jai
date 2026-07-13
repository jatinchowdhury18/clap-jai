// This extension let the plugin provide a structured way of mapping parameters to an hardware
// controller.
//
// This is done by providing a set of remote control pages organized by section.
// A page contains up to 8 controls, which references parameters using param_id.
//
// |`- [section:main]
// |    `- [name:main] performance controls
// |`- [section:osc]
// |   |`- [name:osc1] osc1 page
// |   |`- [name:osc2] osc2 page
// |   |`- [name:osc-sync] osc sync page
// |    `- [name:osc-noise] osc noise page
// |`- [section:filter]
// |   |`- [name:flt1] filter 1 page
// |    `- [name:flt2] filter 2 page
// |`- [section:env]
// |   |`- [name:env1] env1 page
// |    `- [name:env2] env2 page
// |`- [section:lfo]
// |   |`- [name:lfo1] env1 page
// |    `- [name:lfo2] env2 page
//  `- etc...
//
// One possible workflow is to have a set of buttons, which correspond to a section.
// Pressing that button once gets you to the first page of the section.
// Press it again to cycle through the section's pages.

CLAP_EXT_REMOTE_CONTROLS :: "clap.remote-controls/2\0";

// The latest draft is 100% compatible
// This compat ID may be removed in 2026.
CLAP_EXT_REMOTE_CONTROLS_COMPAT :: "clap.remote-controls.draft/2\0";

CLAP_REMOTE_CONTROLS_COUNT :: 8;

clap_remote_controls_page_t :: struct {
    section_name: [CLAP_NAME_SIZE] char;
    page_id: clap_id;
    page_name: [CLAP_NAME_SIZE] char;
    param_ids: [CLAP_REMOTE_CONTROLS_COUNT] clap_id;

    // This is used to separate device pages versus preset pages.
    // If true, then this page is specific to this preset.
    is_for_preset: bool;
}

clap_plugin_remote_controls_t :: struct {
    // Returns the number of pages.
    // [main-thread]
    count: (plugin: *clap_plugin_t) -> u32 #c_call;

    // Get a page by index.
    // Returns true on success and stores the result into page.
    // [main-thread]
    get: (plugin: *clap_plugin_t, page_index: u32, page: *clap_remote_controls_page_t) -> bool #c_call;
}

clap_host_remote_controls_t :: struct {
    // Informs the host that the remote controls have changed.
    // [main-thread]
    changed: (host: *clap_host_t) -> void #c_call;

    // Suggest a page to the host because it corresponds to what the user is currently editing in the
    // plugin's GUI.
    // [main-thread]
    suggest_page: (host: *clap_host_t, page_id: clap_id) -> void #c_call;
}
