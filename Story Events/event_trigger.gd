extends Area3D

@export var story_event: StoryEvent

func _on_body_entered(body: Node3D) -> void:
	get_tree().get_first_node_in_group("interaction_manager").add_event(story_event)

func _on_body_exited(body: Node3D) -> void:
	var interact = get_tree().get_first_node_in_group("interaction_manager")
	if interact:
		interact.remove_event(story_event)
