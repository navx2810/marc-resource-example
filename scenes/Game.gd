extends CanvasLayer

export var spawn_notice: PackedScene
export var _level: Resource
onready var spawn_timer := $SpawnTimer
onready var popup: Popup = $Control/Popup
onready var container := $Control/GridContainer
onready var level_label := $Control/GridContainer/LevelName

func _handle_spawn():
	_level.spawn()
	
func _handle_spawned(wave: Wave):
	var notice = spawn_notice.instance()
	notice.init(wave)
	container.add_child(notice)

func _handle_level_completed():
	popup.popup_centered_minsize(Vector2(200, 100))
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().quit()

func _ready():
	_level.connect("level_completed", self, "_handle_level_completed")
	_level.connect("spawned", self, "_handle_spawned")
	
	_level.spawn()
	level_label.text = _level.id
	
	spawn_timer.wait_time = _level.respawn_time
	spawn_timer.connect("timeout", self, "_handle_spawn")
	spawn_timer.start()
