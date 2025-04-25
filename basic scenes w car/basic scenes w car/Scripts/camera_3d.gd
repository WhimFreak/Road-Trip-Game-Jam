extends Camera3D

func _process(delta: float) -> void:
	var car = get_tree().get_first_node_in_group("car")
	if car:
		global_position = Vector3(car.global_position.x, global_position.y, car.global_position.z)
