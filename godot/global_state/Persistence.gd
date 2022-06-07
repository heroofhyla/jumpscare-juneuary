# Manages all data that needs to be accessed globally, and all data that needs
# be saved between sessions. Supports creating new save slots or saving over
# existing slots. Also supports global config that should be shared between
# all slots.

# Keep these data structures as flat as possible. Nested dictionaries could
# cause problems.

extends Node

signal global_data_loaded()
signal slot_loaded(slot_name)

const global_data_file := "user://global_settings"
const saves_directory := "user://saves"

var game_data := {
	
}

# Used by the audio system to save volume settings
var audio := {
	sfx_volume = 100,
	music_volume = 100
}

func merge_dict(base, overlay):
	for key in overlay:
		base[key] = overlay[key]
