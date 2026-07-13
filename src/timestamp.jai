// This type defines a timestamp: the number of seconds since UNIX EPOCH.
// See C's time_t time(time_t *).
clap_timestamp :: #type u64;

// Value for unknown timestamp.
CLAP_TIMESTAMP_UNKNOWN : clap_timestamp : 0;
