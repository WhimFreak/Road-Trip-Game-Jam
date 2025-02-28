class_name StoryEvent
extends Resource

@export var scenes: Array[Scene] # Append individual scenes to this

func get_scene(scene_number: int) -> Scene:
	if scenes.size() < scene_number:
		return null
	
	return scenes[scene_number - 1]
