extends Node

# Interaction manager deals with situations where the player is in range of multiple interactables
# The closest interactable takes priority

@onready var interact_label: Label = %InteractLabel
@onready var camera: Node3D = %Camera

var interactables: Array[InteractionArea] = []
var in_dialog: bool = false # For now, just to hide the label during dialog

func _ready() -> void:
	Dialogic.timeline_started.connect(on_timeline_start)
	Dialogic.timeline_ended.connect(on_timeline_end)
	
func on_timeline_start():
	in_dialog = true

func on_timeline_end():
	in_dialog = false

func _process(_delta: float) -> void:
	if interactables.is_empty() or in_dialog:
		interact_label.hide()
	else:
		interact_label.show()

func add_interactable(interact: InteractionArea):
	if not interactables.has(interact):
		interactables.append(interact)
		
func remove_interactable(interact: InteractionArea):
	interactables.erase(interact)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if interactables.is_empty():
			return
		
		# Search for the closest interaction area and trigger its interact function
		
		var closest_to_player: InteractionArea = null
		
		for i in interactables:
			var car = get_tree().get_first_node_in_group("vehicle")
			if closest_to_player == null:
				closest_to_player = i
			elif i.global_position.distance_to(car.global_position) < closest_to_player.global_position.distance_to(car.global_position):
				closest_to_player = i
		
		trigger_interact(closest_to_player)
				
func trigger_interact(interactable: InteractionArea):
	camera.focus_on_point(interactable.global_position)
	interactable.on_interact()
			
