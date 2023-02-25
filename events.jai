// event header
// must be the first attribute of the event
clap_event_header_t :: struct {
    size: u32;     // event size including this header, eg: sizeof (clap_event_note)
    time: u32;     // sample offset within the buffer for this event
    space_id: u16; // event space, see clap_host_event_registry
    type: u16;     // event type
    flags: u32;    // see clap_event_flags
}

// The clap core event space
CLAP_CORE_EVENT_SPACE_ID : u16 : 0;

clap_event_flags :: enum u32 {
    // Indicate a live user event, for example a user turning a physical knob
    // or playing a physical key.
    CLAP_EVENT_IS_LIVE :: 1 << 0;
 
    // Indicate that the event should not be recorded.
    // For example this is useful when a parameter changes because of a MIDI CC,
    // because if the host records both the MIDI CC automation and the parameter
    // automation there will be a conflict.
    CLAP_EVENT_DONT_RECORD :: 1 << 1;
}

// Some of the following events overlap, a note on can be expressed with:
// - CLAP_EVENT_NOTE_ON
// - CLAP_EVENT_MIDI
// - CLAP_EVENT_MIDI2
//
// The preferred way of sending a note event is to use CLAP_EVENT_NOTE_*.
//
// The same event must not be sent twice: it is forbidden to send a the same note on
// encoded with both CLAP_EVENT_NOTE_ON and CLAP_EVENT_MIDI.
//
// The plugins are encouraged to be able to handle note events encoded as raw midi or midi2,
// or implement clap_plugin_event_filter and reject raw midi and midi2 events.

// NOTE_ON and NOTE_OFF represent a key pressed and key released event, respectively.
// A NOTE_ON with a velocity of 0 is valid and should not be interpreted as a NOTE_OFF.
//
// NOTE_CHOKE is meant to choke the voice(s), like in a drum machine when a closed hihat
// chokes an open hihat. This event can be sent by the host to the plugin. Here are two use
// cases:
// - a plugin is inside a drum pad in Bitwig Studio's drum machine, and this pad is choked by
//   another one
// - the user double clicks the DAW's stop button in the transport which then stops the sound on
//   every tracks
//
// NOTE_END is sent by the plugin to the host. The port, channel, key and note_id are those given
// by the host in the NOTE_ON event. In other words, this event is matched against the
// plugin's note input port.
// NOTE_END is useful to help the host to match the plugin's voice life time.
//
// When using polyphonic modulations, the host has to allocate and release voices for its
// polyphonic modulator. Yet only the plugin effectively knows when the host should terminate
// a voice. NOTE_END solves that issue in a non-intrusive and cooperative way.
//
// CLAP assumes that the host will allocate a unique voice on NOTE_ON event for a given port,
// channel and key. This voice will run until the plugin will instruct the host to terminate
// it by sending a NOTE_END event.
//
// Consider the following sequence:
// - process()
//    Host->Plugin NoteOn(port:0, channel:0, key:16, time:t0)
//    Host->Plugin NoteOn(port:0, channel:0, key:64, time:t0)
//    Host->Plugin NoteOff(port:0, channel:0, key:16, t1)
//    Host->Plugin NoteOff(port:0, channel:0, key:64, t1)
//    # on t2, both notes did terminate
//    Host->Plugin NoteOn(port:0, channel:0, key:64, t3)
//    # Here the plugin finished processing all the frames and will tell the host
//    # to terminate the voice on key 16 but not 64, because a note has been started at t3
//    Plugin->Host NoteEnd(port:0, channel:0, key:16, time:ignored)
//
// These four events use clap_event_note.
CLAP_EVENT_NOTE_ON : u16 : 0;
CLAP_EVENT_NOTE_OFF : u16 : 1;
CLAP_EVENT_NOTE_CHOKE : u16 : 2;
CLAP_EVENT_NOTE_END : u16 : 3;

// Represents a note expression.
// Uses clap_event_note_expression.
CLAP_EVENT_NOTE_EXPRESSION : u16 : 4;

// PARAM_VALUE sets the parameter's value; uses clap_event_param_value.
// PARAM_MOD sets the parameter's modulation amount; uses clap_event_param_mod.
//
// The value heard is: param_value + param_mod.
//
// In case of a concurrent global value/modulation versus a polyphonic one,
// the voice should only use the polyphonic one and the polyphonic modulation
// amount will already include the monophonic signal.
CLAP_EVENT_PARAM_VALUE : u16 : 5;
CLAP_EVENT_PARAM_MOD : u16 : 6;

// Indicates that the user started or finished adjusting a knob.
// This is not mandatory to wrap parameter changes with gesture events, but this improves
// the user experience a lot when recording automation or overriding automation playback.
// Uses clap_event_param_gesture.
CLAP_EVENT_PARAM_GESTURE_BEGIN : u16 : 7;
CLAP_EVENT_PARAM_GESTURE_END : u16 : 8;

CLAP_EVENT_TRANSPORT : u16 : 9;   // update the transport info; clap_event_transport
CLAP_EVENT_MIDI : u16 : 10;       // raw midi event; clap_event_midi
CLAP_EVENT_MIDI_SYSEX : u16 : 11; // raw midi sysex event; clap_event_midi_sysex
CLAP_EVENT_MIDI2 : u16 : 12;      // raw midi 2 event; clap_event_midi2


// Note on, off, end and choke events.
// In the case of note choke or end events:
// - the velocity is ignored.
// - key and channel are used to match active notes, a value of -1 matches all.
clap_event_note_t :: struct {
    header: clap_event_header_t;

   note_id: s32; // -1 if unspecified, otherwise >=0
    port_index: s16;
    channel: s16;  // 0..15
    key: s16;      // 0..127
    velocity: float64; // 0..1
}

clap_note_expression :: enum s32 {
    // with 0 < x <= 4, plain = 20 * log(x)
    CLAP_NOTE_EXPRESSION_VOLUME :: 0;

    // pan, 0 left, 0.5 center, 1 right
    CLAP_NOTE_EXPRESSION_PAN :: 1;

    // relative tuning in semitone, from -120 to +120
    CLAP_NOTE_EXPRESSION_TUNING :: 2;

    // 0..1
    CLAP_NOTE_EXPRESSION_VIBRATO :: 3;
    CLAP_NOTE_EXPRESSION_EXPRESSION :: 4;
    CLAP_NOTE_EXPRESSION_BRIGHTNESS :: 5;
    CLAP_NOTE_EXPRESSION_PRESSURE :: 6;
}

clap_event_note_expression_t :: struct {
    header: clap_event_header_t;

    expression_id: clap_note_expression;

    // target a specific note_id, port, key and channel, -1 for global
    note_id: s32;
    port_index: s16;
    channel: s16;
    key: s16;

    value: float64; // see expression for the range
}

clap_event_param_value_t :: struct {
    header: clap_event_header_t;

    // target parameter
    param_id: clap_id; // @ref clap_param_info.id
    cookie: *void;   // @ref clap_param_info.cookie

    // target a specific note_id, port, key and channel, -1 for global
    note_id: s32;
    port_index: s16;
    channel: s16;
    key: s16;

    value: float64;
}

clap_event_param_mod_t :: struct {
    header: clap_event_header_t;

    // target parameter
    param_id: clap_id; // @ref clap_param_info.id
    cookie: *void;   // @ref clap_param_info.cookie

    // target a specific note_id, port, key and channel, -1 for global
    note_id: s32;
    port_index: s16;
    channel: s16;
    key: s16;

    amount: float64; // modulation amount
}

clap_event_param_gesture_t :: struct {
    header: clap_event_header_t;

    // target parameter
    param_id: clap_id; // @ref clap_param_info.id
}

clap_transport_flags :: enum u32 {
    CLAP_TRANSPORT_HAS_TEMPO :: 1 << 0;
    CLAP_TRANSPORT_HAS_BEATS_TIMELINE :: 1 << 1;
    CLAP_TRANSPORT_HAS_SECONDS_TIMELINE :: 1 << 2;
    CLAP_TRANSPORT_HAS_TIME_SIGNATURE :: 1 << 3;
    CLAP_TRANSPORT_IS_PLAYING :: 1 << 4;
    CLAP_TRANSPORT_IS_RECORDING :: 1 << 5;
    CLAP_TRANSPORT_IS_LOOP_ACTIVE :: 1 << 6;
    CLAP_TRANSPORT_IS_WITHIN_PRE_ROLL :: 1 << 7;
}

clap_event_transport_t :: struct {
    header: clap_event_header_t;

    flags: clap_transport_flags; // see clap_transport_flags

    song_pos_beats: clap_beattime;   // position in beats
    song_pos_seconds: clap_sectime;  // position in seconds

    tempo: float64;      // in bpm
    tempo_inc: float64;  // tempo increment for each samples and until the next
                         // time info event

    loop_start_beats: clap_beattime;
    loop_end_beats: clap_beattime;
    loop_start_seconds: clap_sectime;
    loop_end_seconds: clap_sectime;

    bar_start: clap_beattime;  // start pos of the current bar
    bar_number: s32; // bar at song pos 0 has the number 0

    tsig_num: u16;   // time signature numerator
    tsig_denom: u16; // time signature denominator
}

clap_event_midi_t :: struct {
    header: clap_event_header_t;

    port_index: u16;
    data: [3] u8;
}

clap_event_midi_sysex_t :: struct {
    header: clap_event_header_t;

    port_index: u16;
    buffer: *u8; // midi buffer (const)
    size: u32;
}

// While it is possible to use a series of midi2 event to send a sysex,
// prefer clap_event_midi_sysex if possible for efficiency.
clap_event_midi2_t :: struct {
    header: clap_event_header_t;

    port_index: u16;
    data: [4] u32;
}

// Input event list, events must be sorted by time.
clap_input_events_t :: struct {
    ctx: *void; // reserved pointer for the list

    // returns the number of events in the list
    Func_size :: #type (list: *clap_input_events_t) -> u32 #c_call;
    size: Func_size;

    // Don't free the returned event, it belongs to the list
    Func_get :: #type (list: *clap_input_events_t, index: u32) -> *clap_event_header_t #c_call;
    get: Func_get;
}

// Output event list, events must be sorted by time.
clap_output_events_t :: struct {
    ctx: *void; // reserved pointer for the list

    // Pushes a copy of the event
    // returns false if the event could not be pushed to the queue (out of memory?)
    Func_try_push :: #type (list: *clap_output_events_t, event: *clap_event_header_t) -> bool #c_call;
    try_push: Func_try_push;
}
