extends NavigationRegion3D

const OBSTACLE = preload("res://Scenes/obstacle.tscn")

@export var max_distance_from_player: float = 100
@export var min_distance_from_player: float = 40
@export var min_distance_from_other_obstacles: float = 12
@export var min_distance_before_despawning: float = 80
@export var obstacles_per_spawn: int = 2
@export var max_obstacles: int = 20

@onready var obstacles: Node = $Obstacles
@onready var collision_shape_3d: CollisionShape3D = $NavMesh/CollisionShape3D

var fish: CharacterBody3D
var car

var max_recursion: int = 50 # Prevents spawn_obstacles from looping infinitely
var recursion_limiter: int = 0

func _ready() -> void:
	await get_tree().process_frame
	fish = get_tree().get_first_node_in_group("fish")
	car = get_tree().get_first_node_in_group("car")

func _process(_delta: float) -> void:
	if fish:
		global_position.x = fish.global_position.x
		global_position.z = fish.global_position.z
		
func spawn_obstacle():
	if recursion_limiter >= max_recursion:
		return
	
	recursion_limiter += 1	
		
	var spawn_point: Vector3 = Vector3(
		randf_range(car.position.x - max_distance_from_player, car.position.x + max_distance_from_player),
		0,
		randf_range(car.position.z - max_distance_from_player, car.position.z + max_distance_from_player)
		)
	
	if spawn_point.distance_to(car.global_position) < min_distance_from_player:
		spawn_obstacle() # Loop back if spawn point is near player
		
	else:
		var near_obstacles: bool = false
		for obstacle in obstacles.get_children():
			if spawn_point.distance_to(obstacle.global_position) < min_distance_from_other_obstacles:
				near_obstacles = true
				
		if near_obstacles:
			spawn_obstacle() # Loop back if spawn point is near another obstacle
			
		else:
			var new_obstacle = OBSTACLE.instantiate()
			new_obstacle.hide()
			obstacles.add_child(new_obstacle)
			new_obstacle.global_position = spawn_point
			await get_tree().process_frame
			new_obstacle.show()

func _on_spawn_timer_timeout() -> void: # Handles both spawning and despawning
	for obstacle in obstacles.get_children():
		if obstacle.global_position.distance_to(car.global_position) > min_distance_before_despawning:
			obstacle.queue_free()
	
	if obstacles.get_child_count() >= max_obstacles:
		return		
			
	for i in obstacles_per_spawn:
		recursion_limiter = 0
		spawn_obstacle()
