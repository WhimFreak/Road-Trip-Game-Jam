class_name Scene
extends Resource

@export var background: Texture2D
@export_multiline var text: String

func play_scene(bg: TextureRect, label: Label): # Nodes are passed to this function to be modified
	bg.texture = background
	label.text = text
