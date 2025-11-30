extends Node

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("give_points"):
		GlobalVars.score += 100
	if Input.is_action_pressed("give_thousand_points"):
		GlobalVars.score += 1000
	if Input.is_action_pressed("give_million_points"):
		GlobalVars.score += 10000000000000
	if Input.is_action_just_pressed("zero_points"):
		GlobalVars.score = 0
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		GlobalVars.score = 0
		
func _process(delta: float) -> void:
	AudioPlayer.dynamic_music()
	if GlobalVars.score >= 10 and GlobalVars.score < 100:
		GlobalVars.music_stage = 1
	if GlobalVars.score >= 100 and GlobalVars.score < 1000:
		GlobalVars.music_stage = 2
	if GlobalVars.score >= 1000 and GlobalVars.score < 10000:
		GlobalVars.music_stage = 3
	if GlobalVars.score >= 10000 and GlobalVars.score < 100000:
		GlobalVars.music_stage = 4
	if GlobalVars.score >= 100000:
		GlobalVars.music_stage = 5
	
