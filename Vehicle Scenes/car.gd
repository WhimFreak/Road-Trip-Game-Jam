extends VehicleBody3D

var max_rpm = 500
var max_torque = 200

func _physics_process(delta):
	
	
	steering = lerp(steering,Input.get_axis("Move_right","Move_left")  *  0.4 , 5 * delta) 
	
	var acceleration = Input.get_axis("Move_down", "Move_up") 
	var rpm = abs($Back_left.get_rpm()) #Returns the rotational speed of the wheel in revolutions per minute.
	
	$Back_left.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	
	#Accelerates the wheel by applying an engine force.
	# The wheel is only sped up if it is in contact with a surface. The RigidBody3D.mass of the vehicle has an 
	# effect on the acceleration of the vehicle.
	
	rpm = abs($Back_right.get_rpm()) #Returns the rotational speed of the wheel in revolutions per minute.
	
	$Back_right.engine_force = acceleration * max_torque *(1 - rpm / max_rpm) # 
