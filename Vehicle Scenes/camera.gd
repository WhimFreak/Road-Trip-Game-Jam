extends Node3D

@export var turn_speed: float = 8

@onready var camera_3d: Camera3D = $Camera3D

var can_rotate: bool = true

func _ready() -> void:
	Dialogic.timeline_ended.connect(on_timeline_ended)

func _process(delta: float) -> void:
	if not can_rotate:
		return
		
	var vehicle = get_tree().get_first_node_in_group("vehicle")
	if vehicle:
		global_position = vehicle.global_position + Vector3(0, 0, 0)
		
	rotation.y = lerp_angle(rotation.y, rotation.y + (Input.get_axis("turn_camera_right", "turn_camera_left") * turn_speed * delta), 0.25)

func on_timeline_ended():
	can_rotate = true

func focus_on_point(point: Vector3):
	can_rotate = false
	look_at(point)
	rotation.x = 0
	rotation.z = 0
