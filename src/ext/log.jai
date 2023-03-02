CLAP_EXT_LOG :: "clap.log\0";

clap_log_severity :: enum s32 {
   CLAP_LOG_DEBUG :: 0;
   CLAP_LOG_INFO :: 1;
   CLAP_LOG_WARNING :: 2;
   CLAP_LOG_ERROR :: 3;
   CLAP_LOG_FATAL :: 4;

   // These severities should be used to report misbehaviour.
   // The plugin one can be used by a layer between the plugin and the host.
   CLAP_LOG_HOST_MISBEHAVING :: 5;
   CLAP_LOG_PLUGIN_MISBEHAVING :: 6;
}

clap_host_log_t :: struct {
    // Log a message through the host.
    // [thread-safe]
    log: (host: *clap_host_t, severity: clap_log_severity, msg: *char) -> void #c_call;
}
