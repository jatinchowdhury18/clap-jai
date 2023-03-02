clap_version_t :: struct {
    // This is the major ABI and API design
    // Version 0.X.Y correspond to the development stage, API and ABI are not stable
    // Version 1.X.Y correspont to the release stage, API and ABI are stable
    major: u32;
    minor: u32;
    revision: u32;
}

CLAP_VERSION_MAJOR : u32 : 1;
CLAP_VERSION_MINOR : u32 : 1;
CLAP_VERSION_REVISION : u32 : 7;

CLAP_VERSION :: clap_version_t.{ CLAP_VERSION_MAJOR, CLAP_VERSION_MINOR, CLAP_VERSION_REVISION };

clap_version_is_compatible :: (v: clap_version_t) -> bool {
    // versions 0.x.y were used during development stage and aren't compatible
    return v.major >= 1;
}
