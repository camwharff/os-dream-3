extends Node

const PATH: String = "user://settings.cgf"

var music_vol: int = 0.5
var sfx_vol: int = 0.5
var fullscreen = false


func _ready() -> void:
	load_settings()


func load_settings():
	var config: ConfigFile = ConfigFile.new()
	var error = config.load(PATH)

	if error != OK:
		save_settings()
	else:
		music_vol = config.get_value("audio", "music_vol", 0.5)
		sfx_vol = config.get_value("audio", "sfx_vol", 0.5)
		fullscreen = config.get_value("display", "fullscreen", false)
	apply_settings()


func save_settings():
	var config: ConfigFile = ConfigFile.new()
	config.set_value("audio", "music_vol", music_vol)
	config.set_value("audio", "sfx_vol", sfx_vol)
	config.set_value("display", "fullscreen", fullscreen)
	config.save(PATH)


func apply_settings():
	_set_bus_volume("Music", music_vol)
	_set_bus_volume("SFX", sfx_vol)
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _set_bus_volume(bus: String, val: float) -> void:
	var i := AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(i, linear_to_db(val)) # set volume linearly to value
	AudioServer.set_bus_mute(i, val <= 0.0) # mute when sliders at 0


func set_music_volume(vol: float) -> void:
	music_vol = vol
	apply_settings()
	save_settings()


func set_sfx_volume(vol: float) -> void:
	sfx_vol = vol
	apply_settings()
	save_settings()


func set_fullscreen(val: bool) -> void:
	fullscreen = val
	apply_settings()
	save_settings()
