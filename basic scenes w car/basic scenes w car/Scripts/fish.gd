extends CharacterBody3D

@export var starting_max_speed: float = 5
@export var steer_force: float = 0.05
@export var nav_range: float = 12
@export var min_switch_time: float = 3
@export var max_switch_time: float = 4

@onready var direction_switch_timer: Timer = $DirectionSwitchTimer
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var chosen_dir: Vector3 = Vector3.ZERO
var random_dir: Vector3 = Vector3.ZERO

var can_move: bool = false
var max_speed: float

func _ready() -> void:
	NavigationServer3D.map_changed.connect(on_map_changed)
	direction_switch_timer.start(randf_range(min_switch_time, max_switch_time))
	max_speed = starting_max_speed
	set_random_direction()
	
func on_map_changed(map: RID):
	can_move = true
	
func _physics_process(delta: float) -> void:
	if not can_move:
		return
		
	navigation_agent_3d.target_position = global_position + random_dir * nav_range
	chosen_dir = (navigation_agent_3d.get_next_path_position() - global_position).normalized()
	
	var look_target = global_position + velocity
	look_target.y = 0

	if velocity.length() > 0:
		look_at(look_target, Vector3.FORWARD)
	
	if navigation_agent_3d.avoidance_enabled:
		navigation_agent_3d.set_velocity(chosen_dir * max_speed)
	else:
		_on_navigation_agent_3d_velocity_computed(chosen_dir * max_speed)

	move_and_slide()
	
func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	if safe_velocity.length() > 0.1:
		velocity = lerp(velocity, safe_velocity.normalized() * max_speed, steer_force)
	else:
		velocity = lerp(velocity, safe_velocity, steer_force)

func set_random_direction():
	random_dir = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()

func _on_direction_switch_timer_timeout() -> void:
	set_random_direction()
	direction_switch_timer.start(randf_range(min_switch_time, max_switch_time))
