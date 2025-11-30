extends Control

@onready var background_anim = $background_anim

func _ready() -> void:
	background_anim.play("rgb_background")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shop"):
		AudioPlayer.open_menu_gui()
		get_tree().change_scene_to_file("res://scenes/clicking/clicker.tscn")

func _on_go_back_pressed() -> void:
	AudioPlayer.close_menu_gui()
	get_tree().change_scene_to_file("res://scenes/clicking/clicker.tscn")
