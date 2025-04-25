extends Node3D

var timer: float = 0
var score: float = 0

@onready var timer_label: Label = %TimerLabel

var is_counting: bool = false

func _ready() -> void:
	on_game_start()
	
func on_game_start():
	timer = 0
	score = 0
	is_counting = true
	SoundHandler.play_game()

func _process(delta: float) -> void:
	if not is_counting:
		return
		
	timer += delta
	
	score = snappedf(timer, 0.01)
	# Limits number to two decimals. Timer is a separate variable for better accuracy
	timer_label.text = str(score)

func on_game_lose(): # Connect to whatevers handling the lose state
	SoundHandler.lose()
	ScoreData.set_score(score)
	is_counting = false
