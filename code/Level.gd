extends Resource

class_name Level

signal level_completed
signal spawned(wave)

export var id: String
export var respawn_time := 1.0
export(Array, Resource) var waves = []

func spawn():
	var wave: Wave = waves.pop_front()
	if wave:
		emit_signal("spawned", wave)
	else:
		emit_signal("level_completed")
