extends Node

var last_score: float = 0
var high_score: float = 0

func set_score(new_score: float):
	last_score = new_score
	if new_score > high_score:
		high_score = new_score
	print(high_score)
