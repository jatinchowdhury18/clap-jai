// This extension let the plugin query info about the track it's in.
// It is useful when the plugin is created, to initialize some parameters (mix, dry, wet)
// and pick a suitable configuration regarding audio port type and channel count.

CLAP_EXT_TRACK_INFO :: "clap.track-info/1\0";

// The latest draft is 100% compatible.
// This compat ID may be removed in 2026.
CLAP_EXT_TRACK_INFO_COMPAT :: "clap.track-info.draft/1\0";

CLAP_TRACK_INFO_HAS_TRACK_NAME : u32 : 1 << 0;
CLAP_TRACK_INFO_HAS_TRACK_COLOR : u32 : 1 << 1;
CLAP_TRACK_INFO_HAS_AUDIO_CHANNEL : u32 : 1 << 2;

// This plugin is on a return track, initialize with wet 100%
CLAP_TRACK_INFO_IS_FOR_RETURN_TRACK : u32 : 1 << 3;

// This plugin is on a bus track, initialize with appropriate settings for bus processing
CLAP_TRACK_INFO_IS_FOR_BUS : u32 : 1 << 4;

// This plugin is on the master, initialize with appropriate settings for channel processing
CLAP_TRACK_INFO_IS_FOR_MASTER : u32 : 1 << 5;

clap_track_info_t :: struct {
    flags: u64; // see the flags above

    // track name, available if flags contain CLAP_TRACK_INFO_HAS_TRACK_NAME
    name: [CLAP_NAME_SIZE] char;

    // track color, available if flags contain CLAP_TRACK_INFO_HAS_TRACK_COLOR
    color: clap_color_t;

    // available if flags contain CLAP_TRACK_INFO_HAS_AUDIO_CHANNEL
    // see audio-ports.h, struct clap_audio_port_info to learn how to use channel count and port type
    audio_channel_count: s32;
    audio_port_type: *char;
}

clap_plugin_track_info_t :: struct {
    // Called when the info changes.
    // [main-thread]
    changed: (plugin: *clap_plugin_t) -> void #c_call;
}

clap_host_track_info_t :: struct {
    // Get info about the track the plugin belongs to.
    // Returns true on success and stores the result into info.
    // [main-thread]
    get: (host: *clap_host_t, info: *clap_track_info_t) -> bool #c_call;
}
