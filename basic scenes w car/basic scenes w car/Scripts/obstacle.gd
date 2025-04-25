extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var obstacle_1: Node3D = $"obstacle-1"
@onready var obstacle_2: Node3D = $"obstacle-2"

func _ready() -> void:
	obstacle_1.hide()
	obstacle_2.hide()
	
	if randf() > 0.5:
		obstacle_1.show()
	else:
		obstacle_2.show()
	animation_player.play("spawn")
