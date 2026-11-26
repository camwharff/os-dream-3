extends Control

# add menu res://scenes/ui/settings_menu.tscn when it exists
const SETTINGS_MENU: Control = preload("")


func _on_new_game_pressed() -> void:
	GameState.new_run()
	# replace string with courtyard location (res://scenes/rooms/courtyard.tscn) when implemented
	SceneManager.go_to("")


func _on_settings_pressed() -> void:
	var settings_menu = SETTINGS_MENU.instantiate()
	add_child(settings_menu)


func _on_quit_pressed() -> void:
	get_tree().quit()
