extends CanvasLayer

@onready var scene_change_player: AnimationPlayer = $scene_change_player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_scene():
	if scene_change_player.is_playing():
		scene_change_player.stop()
	scene_change_player.play("fade_in_and_out")
	
func new_scene():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main_scene.tscn")
	
	
