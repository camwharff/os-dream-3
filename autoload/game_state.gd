extends Node

signal time_up
signal time_changed

var phase: int
var seed: int
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var stats: Dictionary[String, int] = {
	"energy": 0,
	"happiness": 0,
	"sanity": 0,
	"stress": 0,
}
var time_left: int
var puzzle_results: Dictionary[String, bool] = {
	"matching": false,
	"minesweeper": false,
	"ordering": false,
}
var code_digits: Array[int]
var lock_tries_left: int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func new_run(custom_seed: int = 0):
	phase = 0
	if custom_seed == 0:
		seed = randi()
	else:
		seed = custom_seed
	rng.seed = seed
	stats = { "energy": 0, "happiness": 0, "sanity": 0, "stress": 0 }
	time_left = 0
	puzzle_results = {
		"matching": false,
		"minesweeper": false,
		"ordering": false,
	}
	code_digits = [
		rng.randi_range(1, 9),
		rng.randi_range(1, 9),
		rng.randi_range(1, 9),
	]
	lock_tries_left = 3


func change_stat(stat: String, amount: int):
	stats[stat] = amount


func tick_time(amount: int):
	time_left -= amount
	time_changed.emit()
	if time_left <= 0:
		time_up.emit()
