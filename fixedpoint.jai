/// We use fixed point representation of beat time and seconds time
/// Usage:
///   double x = ...; // in beats
///   clap_beattime y = round(CLAP_BEATTIME_FACTOR * x);

// This will never change
CLAP_BEATTIME_FACTOR : s64 : 1 << 31;
CLAP_SECTIME_FACTOR : s64 : 1 << 31;

clap_beattime :: #type s64;
clap_sectime :: #type s64;
