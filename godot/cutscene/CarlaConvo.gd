extends Node2D
var messages = [
	"""CARLA: "Randall. You're late. We agreed on four thirty. It's nearly seven."
	
	RANDALL: "Sorry."
	
	CARLA: "You're always sorry."
	
	RANDALL: "Sorry." """
]
func run_convo():
	UI.show_messages(messages)

func _ready():
	run_convo()
