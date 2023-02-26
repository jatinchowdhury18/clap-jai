CLAP_EXT_EVENT_REGISTRY :: "clap.event-registry\0";

clap_host_event_registry_t :: struct {
    // Queries an event space id.
    // The space id 0 is reserved for CLAP's core events. See CLAP_CORE_EVENT_SPACE.
    //
    // Return false and sets *space to UINT16_MAX if the space name is unknown to the host.
    // [main-thread]
    query: (host: *clap_host_t, space_name: *char, space_id: u16) -> bool #c_call;
}
