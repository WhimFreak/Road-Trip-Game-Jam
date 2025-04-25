extends Node

@onready var game_music: AudioStreamPlayer2D = $GameMusic
@onready var menu_music: AudioStreamPlayer2D = $MenuMusic
@onready var lose_sfx: AudioStreamPlayer2D = $LoseSFX
@onready var water_noise: AudioStreamPlayer2D = $WaterNoise

func play_menu():
	if menu_music.playing:
		return
	
	game_music.stop()
	water_noise.stop()
	menu_music.play()
	
func play_game():
	if game_music.playing:
		return
	
	water_noise.play()
	menu_music.stop()
	game_music.play()

func lose():
	if lose_sfx.playing:
		return
	
	game_music.stop()
	menu_music.stop()
	lose_sfx.play()
	
	
