extends Node2D

@export var text_reveal_speed: float = 1 # Percent of text shown per second

@export var story_event: StoryEvent

@onready var background: TextureRect = $Background
@onready var text: Label = $CanvasLayer/TextPanel/Text
@onready var fade_transition: ColorRect = $CanvasLayer/FadeTransition

var scene_number: int = 0
var text_fully_revealed: bool = true

func _ready() -> void:
	story_event = GlobalData.current_story_event
	
	var transition_tween: Tween = create_tween()
	transition_tween.tween_property(fade_transition, "self_modulate", Color.TRANSPARENT, 1)
	await transition_tween.finished
	fade_transition.hide()
	change_scene()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_scene"):
		if text_fully_revealed:
			change_scene()
		else:
			text.visible_ratio = 1
		
func _process(delta: float) -> void:
	# Handle revealing text
	if text.visible_ratio < 1:
		text_fully_revealed = false
		text.visible_ratio += text_reveal_speed * delta
	else:
		text_fully_revealed = true

func change_scene():
	scene_number += 1
	var scene = story_event.get_scene(scene_number)
	if scene:
		scene.play_scene(background, text)
		text.visible_ratio = 0
	else:
		fade_transition.show()
		var transition_tween: Tween = create_tween()
		transition_tween.tween_property(fade_transition, "self_modulate", Color.WHITE, 1)
		await transition_tween.finished
		get_tree().change_scene_to_file("res://Main Scenes/main.tscn")
