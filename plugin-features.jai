// This file provides a set of standard plugin features meant to be used
// within clap_plugin_descriptor.features.
//
// For practical reasons we'll avoid spaces and use `-` instead to facilitate
// scripts that generate the feature array.
//
// Non-standard features should be formated as follow: "$namespace:$feature"

/////////////////////
// Plugin category //
/////////////////////

// Add this feature if your plugin can process note events and then produce audio
CLAP_PLUGIN_FEATURE_INSTRUMENT : string : "instrument";

// Add this feature if your plugin is an audio effect
CLAP_PLUGIN_FEATURE_AUDIO_EFFECT : string : "audio-effect";

// Add this feature if your plugin is a note effect or a note generator/sequencer
CLAP_PLUGIN_FEATURE_NOTE_EFFECT : string : "note-effect";

// Add this feature if your plugin converts audio to notes
CLAP_PLUGIN_FEATURE_NOTE_DETECTOR : string : "note-detector";

// Add this feature if your plugin is an analyzer
CLAP_PLUGIN_FEATURE_ANALYZER : string : "analyzer";

/////////////////////////
// Plugin sub-category //
/////////////////////////

CLAP_PLUGIN_FEATURE_SYNTHESIZER : string : "synthesizer";
CLAP_PLUGIN_FEATURE_SAMPLER : string : "sampler";
CLAP_PLUGIN_FEATURE_DRUM : string : "drum"; // For single drum
CLAP_PLUGIN_FEATURE_DRUM_MACHINE : string : "drum-machine";

CLAP_PLUGIN_FEATURE_FILTER : string : "filter";
CLAP_PLUGIN_FEATURE_PHASER : string : "phaser";
CLAP_PLUGIN_FEATURE_EQUALIZER : string : "equalizer";
CLAP_PLUGIN_FEATURE_DEESSER : string : "de-esser";
CLAP_PLUGIN_FEATURE_PHASE_VOCODER : string : "phase-vocoder";
CLAP_PLUGIN_FEATURE_GRANULAR : string : "granular";
CLAP_PLUGIN_FEATURE_FREQUENCY_SHIFTER : string : "frequency-shifter";
CLAP_PLUGIN_FEATURE_PITCH_SHIFTER : string : "pitch-shifter";

CLAP_PLUGIN_FEATURE_DISTORTION : string : "distortion";
CLAP_PLUGIN_FEATURE_TRANSIENT_SHAPER : string : "transient-shaper";
CLAP_PLUGIN_FEATURE_COMPRESSOR : string : "compressor";
CLAP_PLUGIN_FEATURE_LIMITER : string : "limiter";

CLAP_PLUGIN_FEATURE_FLANGER : string : "flanger";
CLAP_PLUGIN_FEATURE_CHORUS : string : "chorus";
CLAP_PLUGIN_FEATURE_DELAY : string : "delay";
CLAP_PLUGIN_FEATURE_REVERB : string : "reverb";

CLAP_PLUGIN_FEATURE_TREMOLO : string : "tremolo";
CLAP_PLUGIN_FEATURE_GLITCH : string : "glitch";

CLAP_PLUGIN_FEATURE_UTILITY : string : "utility";
CLAP_PLUGIN_FEATURE_PITCH_CORRECTION : string : "pitch-correction";
CLAP_PLUGIN_FEATURE_RESTORATION : string : "restoration"; // repair the sound

CLAP_PLUGIN_FEATURE_MULTI_EFFECTS : string : "multi-effects";

CLAP_PLUGIN_FEATURE_MIXING : string : "mixing";
CLAP_PLUGIN_FEATURE_MASTERING : string : "mastering";

////////////////////////
// Audio Capabilities //
////////////////////////

CLAP_PLUGIN_FEATURE_MONO : string : "mono";
CLAP_PLUGIN_FEATURE_STEREO : string : "stereo";
CLAP_PLUGIN_FEATURE_SURROUND : string : "surround";
CLAP_PLUGIN_FEATURE_AMBISONIC : string : "ambisonic";
