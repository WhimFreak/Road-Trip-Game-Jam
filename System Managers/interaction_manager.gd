extends Node3D

const EVENT = preload("res://Main Scenes/event.tscn")

@onready var interact_label: Label = $InteractLabel

var event_queue: Array[StoryEvent]

func _unhandled_input(event: InputEvent) -> void:
	if event_queue.is_empty():
		return

	if event.is_action_pressed("interact"):
		GlobalData.current_story_event = event_queue[0]
		GlobalData.vehicle_position = get_tree().get_first_node_in_group("vehicle").global_position # Save vehicle position to load after event
		get_tree().change_scene_to_packed(EVENT)
		
func add_event(story_event: StoryEvent):
	if not event_queue.has(story_event):
		event_queue.append(story_event)
		
	update_label()

func remove_event(story_event: StoryEvent):
	event_queue.erase(story_event)
	update_label()
	
func update_label():
	if event_queue.is_empty():
		interact_label.hide()
	else:
		interact_label.show()
	
