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
CLAP_PLUGIN_FEATURE_INSTRUMENT : string : "instrument\0";

// Add this feature if your plugin is an audio effect
CLAP_PLUGIN_FEATURE_AUDIO_EFFECT : string : "audio-effect\0";

// Add this feature if your plugin is a note effect or a note generator/sequencer
CLAP_PLUGIN_FEATURE_NOTE_EFFECT : string : "note-effect\0";

// Add this feature if your plugin converts audio to notes
CLAP_PLUGIN_FEATURE_NOTE_DETECTOR : string : "note-detector\0";

// Add this feature if your plugin is an analyzer
CLAP_PLUGIN_FEATURE_ANALYZER : string : "analyzer\0";

/////////////////////////
// Plugin sub-category //
/////////////////////////

CLAP_PLUGIN_FEATURE_SYNTHESIZER : string : "synthesizer\0";
CLAP_PLUGIN_FEATURE_SAMPLER : string : "sampler\0";
CLAP_PLUGIN_FEATURE_DRUM : string : "drum\0"; // For single drum
CLAP_PLUGIN_FEATURE_DRUM_MACHINE : string : "drum-machine\0";

CLAP_PLUGIN_FEATURE_FILTER : string : "filter\0";
CLAP_PLUGIN_FEATURE_PHASER : string : "phaser\0";
CLAP_PLUGIN_FEATURE_EQUALIZER : string : "equalizer\0";
CLAP_PLUGIN_FEATURE_DEESSER : string : "de-esser\0";
CLAP_PLUGIN_FEATURE_PHASE_VOCODER : string : "phase-vocoder\0";
CLAP_PLUGIN_FEATURE_GRANULAR : string : "granular\0";
CLAP_PLUGIN_FEATURE_FREQUENCY_SHIFTER : string : "frequency-shifter\0";
CLAP_PLUGIN_FEATURE_PITCH_SHIFTER : string : "pitch-shifter\0";

CLAP_PLUGIN_FEATURE_DISTORTION : string : "distortion\0";
CLAP_PLUGIN_FEATURE_TRANSIENT_SHAPER : string : "transient-shaper\0";
CLAP_PLUGIN_FEATURE_COMPRESSOR : string : "compressor\0";
CLAP_PLUGIN_FEATURE_LIMITER : string : "limiter\0";

CLAP_PLUGIN_FEATURE_FLANGER : string : "flanger\0";
CLAP_PLUGIN_FEATURE_CHORUS : string : "chorus\0";
CLAP_PLUGIN_FEATURE_DELAY : string : "delay\0";
CLAP_PLUGIN_FEATURE_REVERB : string : "reverb\0";

CLAP_PLUGIN_FEATURE_TREMOLO : string : "tremolo\0";
CLAP_PLUGIN_FEATURE_GLITCH : string : "glitch\0";

CLAP_PLUGIN_FEATURE_UTILITY : string : "utility\0";
CLAP_PLUGIN_FEATURE_PITCH_CORRECTION : string : "pitch-correction\0";
CLAP_PLUGIN_FEATURE_RESTORATION : string : "restoration\0"; // repair the sound

CLAP_PLUGIN_FEATURE_MULTI_EFFECTS : string : "multi-effects\0";

CLAP_PLUGIN_FEATURE_MIXING : string : "mixing\0";
CLAP_PLUGIN_FEATURE_MASTERING : string : "mastering\0";

////////////////////////
// Audio Capabilities //
////////////////////////

CLAP_PLUGIN_FEATURE_MONO : string : "mono\0";
CLAP_PLUGIN_FEATURE_STEREO : string : "stereo\0";
CLAP_PLUGIN_FEATURE_SURROUND : string : "surround\0";
CLAP_PLUGIN_FEATURE_AMBISONIC : string : "ambisonic\0";
