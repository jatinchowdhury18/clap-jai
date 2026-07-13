// This extension lets the host tell the plugin to display a little color based indication on the
// parameter. This can be used to indicate:
// - a physical controller is mapped to a parameter
// - the parameter is current playing an automation
// - the parameter is overriding the automation
// - etc...
//
// The color semantic depends upon the host here and the goal is to have a consistent experience
// across all plugins.

CLAP_EXT_PARAM_INDICATION :: "clap.param-indication/4\0";

// The latest draft is 100% compatible.
// This compat ID may be removed in 2026.
CLAP_EXT_PARAM_INDICATION_COMPAT :: "clap.param-indication.draft/4\0";

// The host doesn't have an automation for this parameter
CLAP_PARAM_INDICATION_AUTOMATION_NONE : u32 : 0;

// The host has an automation for this parameter, but it isn't playing it
CLAP_PARAM_INDICATION_AUTOMATION_PRESENT : u32 : 1;

// The host is playing an automation for this parameter
CLAP_PARAM_INDICATION_AUTOMATION_PLAYING : u32 : 2;

// The host is recording an automation on this parameter
CLAP_PARAM_INDICATION_AUTOMATION_RECORDING : u32 : 3;

// The host should play an automation for this parameter, but the user has started to adjust this
// parameter and is overriding the automation playback
CLAP_PARAM_INDICATION_AUTOMATION_OVERRIDING : u32 : 4;

clap_plugin_param_indication_t :: struct {
    // Sets or clears a mapping indication.
    //
    // has_mapping: does the parameter currently has a mapping?
    // color: if set, the color to use to highlight the control in the plugin GUI
    // label: if set, a small string to display on top of the knob which identifies the hardware
    // controller description: if set, a string which can be used in a tooltip, which describes the
    // current mapping
    //
    // Parameter indications should not be saved in the plugin context, and are off by default.
    // [main-thread]
    set_mapping: (plugin: *clap_plugin_t, param_id: clap_id, has_mapping: bool, color: *clap_color_t, label: *char, description: *char) -> void #c_call;

    // Sets or clears an automation indication.
    //
    // automation_state: current automation state for the given parameter
    // color: if set, the color to use to display the automation indication in the plugin GUI
    //
    // Parameter indications should not be saved in the plugin context, and are off by default.
    // [main-thread]
    set_automation: (plugin: *clap_plugin_t, param_id: clap_id, automation_state: u32, color: *clap_color_t) -> void #c_call;
}
