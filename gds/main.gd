extends Node
var num =15
signal health_changed(new_health)

var chanc=0.2
var chanc_pct:int:
	get:
		return chanc*100

var health = 90.5:
	set(value):
		health = clamp(value,0,100)
		health_changed.emit(health)
# Called when the node enters the scene tree for the first time.
func _ready():
	print("hi")
	$Label.text="hi"
	print(num)
	health =50.5
	print(chanc_pct)

func _input(event):
	if event.is_action_pressed("ac1"):
		var roll= randf()
		if roll<=0.5:
			$Label.text=str(roll)
			$Label.modulate=Color.YELLOW
		elif roll<0.8:
			$Label.text=str(roll)
			$Label.modulate=Color.RED
		else:
			$Label.text=str(roll)
			$Label.modulate=Color.BLUE


func _on_button_1_button_up():
	print("haha")

func _on_button_1_pressed():
	print("dm")


func _on_button_1_button_down():
	#print("lmao")
	pass


func _on_health_changed(new_health):
	print(health)


func _on_next_1_pressed():
	get_tree().change_scene_to_file("res://node_2.tscn")
