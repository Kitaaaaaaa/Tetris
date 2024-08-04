extends Node

var set_mode : int
var highest_score : int 
var score : int
var highest_score_mode : Array[int] =[0,0,0]

func read_file():
	var file = FileAccess.open("res://Score.txt", FileAccess.READ)
	var hs
	for i in range(3):
		hs = file.get_64()
		if hs == null:
			hs = 0
		elif hs != 0:
			highest_score_mode[i] = hs
	file.close()

func write_file():
	var file = FileAccess.open("res://Score.txt", FileAccess.WRITE)
	highest_score_mode[set_mode] = highest_score
	for i in highest_score_mode:
		file.store_64(i)
	file.close()
