extends VehicleBody3D

var can_drive: bool = true

var max_rpm = 500
var max_torque = 200

func _ready() -> void:
	Dialogic.timeline_started.connect(on_timeline_started)
	Dialogic.timeline_ended.connect(on_timeline_ended)
	
func on_timeline_started():
	can_drive = false
	
func on_timeline_ended():
	can_drive = true

func _physics_process(delta):
	if not can_drive:
		# Write something here to stop the vehicle from moving, I can't figure this out lmao
		return
	
	steering = lerp(steering,Input.get_axis("Move_right","Move_left")  *  0.4 , 5 * delta) 
	
	var acceleration = Input.get_axis("Move_down", "Move_up") 
	var rpm = abs($Back_left.get_rpm()) #Returns the rotational speed of the wheel in revolutions per minute.
	
	$Back_left.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	
	#Accelerates the wheel by applying an engine force.
	# The wheel is only sped up if it is in contact with a surface. The RigidBody3D.mass of the vehicle has an 
	# effect on the acceleration of the vehicle.
	
	rpm = abs($Back_right.get_rpm()) #Returns the rotational speed of the wheel in revolutions per minute.
	$Back_right.engine_force = acceleration * max_torque *(1 - rpm / max_rpm) # 
