extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_bt_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://set_mode.tscn")
	


func _on_exit_bt_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://View_1.tscn")
	

func _on_play_bt_pressed():
	$".".hide()
	get_tree().paused = false



func _on_re_play_bt_pressed():
	get_tree().paused = false
	$".".hide()
	get_tree().change_scene_to_file("res://Playing_V.tscn")
