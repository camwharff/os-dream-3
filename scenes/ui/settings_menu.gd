extends Control


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	Settings.set_fullscreen(toggled_on)


func _on_music_vol_value_changed(value: float) -> void:
	Settings.set_music_volume(value)


func _on_sfx_vol_value_changed(value: float) -> void:
	Settings.set_sfx_volume(value)
