clap_istream_t :: struct {
    ctx: *void; // reserved pointer for the stream

    // returns the number of bytes read; 0 indicates end of file and -1 a read error
    read: (stream: *clap_istream_t, buffer: *void, size: u64) -> s64 #c_call;
}

clap_ostream_t :: struct {
    ctx: *void; // reserved pointer for the stream

    // returns the number of bytes written; -1 on write error
    write: (stream: *clap_ostream_t, buffer: *void, size: u64) -> s64 #c_call;
}
