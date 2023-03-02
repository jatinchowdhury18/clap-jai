CLAP_EXT_TIMER_SUPPORT :: "clap.timer-support\0";

clap_plugin_timer_support_t :: struct {
    // [main-thread]
    on_timer: (plugin: *clap_plugin_t, timer_id: clap_id) -> void #c_call;
}

clap_host_timer_support_t :: struct {
    // Registers a periodic timer.
    // The host may adjust the period if it is under a certain threshold.
    // 30 Hz should be allowed.
    // [main-thread]
    register_timer: (host: *clap_host_t, period_ms: u32, timer_id: *clap_id) -> bool #c_call;

    // [main-thread]
    unregister_timer: (host: *clap_host_t, timer_id: *clap_id) -> bool #c_call;
}
