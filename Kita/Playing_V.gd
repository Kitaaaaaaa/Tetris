extends Node
var score=0
var M_score

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.set_mode)

func _input(event):
	if event.is_action_pressed("action_1"):
		score+=10;
		Global.sum_score+=10
		$Label_Score.text=str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_back_pressed():
	get_tree().change_scene_to_file("res://View_1.tscn")
