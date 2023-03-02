// This extension let your plugin hook itself into the host select/poll/epoll/kqueue reactor.
// This is useful to handle asynchronous I/O on the main thread.
CLAP_EXT_POSIX_FD_SUPPORT :: "clap.posix-fd-support\0";

clap_posix_fd_flags_t :: enum u32 {
    // IO events flags, they can be used to form a mask which describes:
    // - which events you are interested in (register_fd/modify_fd)
    // - which events happened (on_fd)
    CLAP_POSIX_FD_READ :: 1 << 0;
    CLAP_POSIX_FD_WRITE :: 1 << 1;
    CLAP_POSIX_FD_ERROR :: 1 << 2;
}

clap_plugin_posix_fd_support_t :: struct {
    // This callback is "level-triggered".
    // It means that a writable fd will continuously produce "on_fd()" events;
    // don't forget using modify_fd() to remove the write notification once you're
    // done writting.
    //
    // [main-thread]
    on_fd: (plugin: *clap_plugin_t, fd: s32, flags: clap_posix_fd_flags_t) -> void #c_call;
}

clap_host_posix_fd_support_t :: struct {
    // [main-thread]
    register_fd: (host: *clap_host_t, fd: s32, flags: clap_posix_fd_flags_t) -> bool #c_call;

    // [main-thread]
    modify_fd: (host: clap_host_t, fd: s32, flags: clap_posix_fd_flags_t) -> bool #c_call;

    // [main-thread]
    unregister_fd: (host: *clap_host_t, fd: s32) -> bool #c_call;
}
