extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mode_1_pressed():
	Global.set_mode=0
	get_tree().change_scene_to_file("res://Playing_V.tscn")


func _on_mode_2_pressed():
	Global.set_mode=1
	get_tree().change_scene_to_file("res://Playing_V.tscn")


func _on_mode_3_pressed():
	Global.set_mode=2
	get_tree().change_scene_to_file("res://Playing_V.tscn")


func _on_mode_back_pressed():
	get_tree().change_scene_to_file("res://View_1.tscn")
