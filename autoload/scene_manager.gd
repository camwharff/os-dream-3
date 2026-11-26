extends Node

@onready var fade: ColorRect = $Fade

var prev_scene: String = ""
var curr_scene: String = ""
var is_trans: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.modulate.a = 0.0


func go_to(path: String, duration: float = 0.3):
	if is_trans:
		return
	is_trans = true
	fade.mouse_filter = Control.MOUSE_FILTER_STOP

	var tween: Tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, duration)
	await tween.finished

	prev_scene = curr_scene
	curr_scene = path
	get_tree().change_scene_to_file(curr_scene)

	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, duration)
	await tween.finished

	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	is_trans = false
