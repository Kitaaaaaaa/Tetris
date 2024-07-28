extends Node

# Called when the node enters the scene tree for the first time.

func _ready():
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://set_mode.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
