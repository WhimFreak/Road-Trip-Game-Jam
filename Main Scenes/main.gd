extends Node3D

@onready var fade_transition: ColorRect = %FadeTransition

func _ready() -> void:
	var transition_tween: Tween = create_tween()
	transition_tween.tween_property(fade_transition, "self_modulate", Color.TRANSPARENT, 1)
	
	# Load vehicle position after story events
	if GlobalData.vehicle_position:
		get_tree().get_first_node_in_group("vehicle").global_position = GlobalData.vehicle_position
