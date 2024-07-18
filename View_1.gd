extends Node

# Called when the node enters the scene tree for the first time.
func button_mode_hide():
	$mode_1.hide()
	$mode_2.hide()
	$mode_3.hide()
	$mode_back.hide()


func button_mode_show():
	$mode_1.show()
	$mode_2.show()
	$mode_3.show()
	$mode_back.show()


func button_begin_hide():
	$Start_Button.hide()
	$Exit_Button.hide()

func button_begin_show():
	$Start_Button.show()
	$Exit_Button.show()


func _ready():
	button_begin_show()
	button_mode_hide()


func _on_start_button_pressed():
	button_begin_hide()
	button_mode_show()


func _on_mode_1_pressed():
	Global.set_mode=1
	get_tree().change_scene_to_file("res://Playing_V.tscn")


func _on_mode_2_pressed():
	Global.set_mode=2
	get_tree().change_scene_to_file("res://Playing_V.tscn")


func _on_mode_3_pressed():
	Global.set_mode=3
	get_tree().change_scene_to_file("res://Playing_V.tscn")


func _on_mode_back_pressed():
	button_begin_show()
	button_mode_hide()


func _on_exit_button_pressed():
	get_tree().quit()
