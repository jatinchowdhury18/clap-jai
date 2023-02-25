clap_istream_t :: struct {
    ctx: *void; // reserved pointer for the stream

    // returns the number of bytes read; 0 indicates end of file and -1 a read error
    Func_read :: #type (stream: *clap_istream_t, buffer: *void, size: u64) -> s64 #c_call;
    read: Func_read;
}

clap_ostream_t :: struct {
    ctx: *void; // reserved pointer for the stream

    // returns the number of bytes written; -1 on write error
    Func_write :: #type (stream: *clap_ostream_t, buffer: *void, size: u64) -> s64 #c_call;
    write: Func_write;
}
