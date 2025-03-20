class_name InteractionArea
extends Area3D

@export var timeline: DialogicTimeline

func on_interact():
	Dialogic.start(timeline)

func _on_body_entered(_body: Node3D) -> void:
	var interaction_manager = get_tree().get_first_node_in_group("interaction_manager")
	if interaction_manager:
		interaction_manager.add_interactable(self)

func _on_body_exited(_body: Node3D) -> void:
	var interaction_manager = get_tree().get_first_node_in_group("interaction_manager")
	if interaction_manager:
		interaction_manager.remove_interactable(self)
