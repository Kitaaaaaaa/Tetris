extends TileMap

#tetrominoes
var i_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
var i_90 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(0, 3)]
var i_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
var i_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(0, 3)]
var i := [i_0, i_90, i_180, i_270]

var t_0 := [Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var t_90 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var t_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 0)]
var t_270 := [Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var t := [t_0, t_90, t_180, t_270]

var o_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o := [o_0, o_90, o_180, o_270]

var z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_90 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var z_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var z := [z_0, z_90, z_180, z_270]

var s_0 := [Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 0)]
var s_90 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s_180 := [Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 0)]
var s_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s := [s_0, s_90, s_180, s_270]

var l_0 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 0), Vector2i(2, 1)]
var l_90 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(1, 2)]
var l_180 := [Vector2i(0, 0),Vector2i(0, 1), Vector2i(1, 0), Vector2i(2, 0)]
var l_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var l := [l_0, l_90, l_180, l_270]

var j_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var j_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(0, 2)]
var j_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(2, 1)]
var j_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)]
var j := [j_0, j_90, j_180, j_270]

var shapes := [i, t, o, z, s, l, j]



#const REWARD : int = 100
var game_running : bool

var tile_id : int = 0

var active_layer : int = 3

var current_block : int 

var block_present
var future_shape
var block_type
var shapes_type: int 
var pos: Vector2i

var x_pos:  int = 4
var y_pos:  int = 1
var check_pos
var x_check_pos

var f_shapes_type : int
var f_block : int
var f_block_color : int

var block_color: int

var speed: float
var time_elapsed : float =0.0
func _ready():
	$"../GameOver_Layer".hide()
	$"../Pause_Layer".hide()
	Global.read_file()
	Global.score = 0
	Global.highest_score = Global.highest_score_mode[Global.set_mode]

	game_running = true
	check_mode()
	update_score()
	pos = Vector2i(x_pos, y_pos)
	shapes_type = randi_range(0,6)
	current_block = randi_range(0,3)
	block_type = shapes[shapes_type][current_block]
	block_color = randi_range(4,10)
	block_present = draw_block(block_type, pos, block_color)
	future_Block()


func update_score():
	$"../Highest_score2".text = str( Global.highest_score)
	$"../Score2".text = str( Global.score)

func _process(delta):
	time_elapsed += delta
	if(game_running == true):
		if(time_elapsed >= 1/speed):
			falling()
			time_elapsed = 0
	else:
		Global.write_file()
		get_tree().paused = true
		$"../GameOver_Layer".show()

func _input(event):
	if event.is_action_pressed("rotate"):
		rota()
	if event.is_action_pressed("move_left"):
		move_left()
	if event.is_action_pressed("move_right"):
		move_right()
	if event.is_action_pressed("move_down"):
		falling()
	if event.is_action_pressed("pause_game"):
		get_tree().paused = true
		$"../Pause_Layer".show()
		
	if event.is_action_pressed("play_back"):
		Global.write_file()
		get_tree().change_scene_to_file("res://set_mode.tscn")


# vẽ khối 
func draw_block(block, pos, tile_id):
	for i in block:
		set_cell(active_layer, pos + i, tile_id, Vector2i(0,0))

func future_Block():
	f_shapes_type = randi_range(0, 6)
	f_block = randi_range(0, 3)
	f_block_color = randi_range(4, 10)
	if(f_shapes_type == 0):
		if(f_block == 0 || f_block == 2):
			future_shape = draw_block(shapes[f_shapes_type][f_block], Vector2i(15, 2), f_block_color)
		else:
			future_shape = draw_block(shapes[f_shapes_type][f_block], Vector2i(16, 2), f_block_color)
	else:
		future_shape = draw_block(shapes[f_shapes_type][f_block], Vector2i(16, 2), f_block_color)

func add_shape():
	pos = Vector2i(x_pos, y_pos)
	shapes_type = f_shapes_type
	current_block = f_block
	block_type = shapes[shapes_type][current_block]
	block_color = f_block_color
	if(f_shapes_type == 0):
		if(f_block == 0 || f_block == 2):
			for i in block_type:
				erase_cell(active_layer, Vector2i(15, 2) + i)
		else:
			for i in block_type:
				erase_cell(active_layer, Vector2i(16, 2) + i)
	else:
		for i in block_type:
			erase_cell(active_layer, Vector2i(16, 2) + i)
	block_present = draw_block(block_type, pos, block_color)
	future_Block()

# xóa khối 
func delete_block():
	for i in block_type:
		erase_cell(active_layer, pos + i)

# xoay khối
func rota():
	block_present = delete_block()
	if(current_block == 0):
		current_block += 1
	elif(current_block == 1):
		current_block += 1
	elif(current_block == 2):
		current_block += 1
	else:
		current_block = 0 
	block_type = shapes[shapes_type][current_block]
	if(check_impact() ):
			if checkmap_block_right() > 10:
				pos -= Vector2i(checkmap_block_right()-checkmap_block_left()-1,0)
			if check_rotate():
				block_type = shapes[shapes_type][current_block]
				block_present = draw_block(block_type , pos, block_color)
			else :
				current_block -= 1
				block_type = shapes[shapes_type][current_block]
				block_present = draw_block(block_type , pos, block_color)
	else:
		current_block -= 1
		block_type = shapes[shapes_type][current_block]
		block_present = draw_block(block_type , pos, block_color)

func check_rotate():
	for i in block_type:
		check_pos = pos + i
		if(get_cell_source_id(active_layer,check_pos,false) != -1):
			return false
	return true

func check_move_left():
	for i in block_type: 
		check_pos = pos + i
		var idl = get_cell_source_id(active_layer, check_pos + Vector2i(-1, 0), false)
		if idl != -1:
			return 1
	return 0

func check_move_right():
	for i in block_type: 
		check_pos = pos + i
		var idr = get_cell_source_id(active_layer, check_pos + Vector2i(1, 0), false)
		if idr != -1:
			return 1
	return 0

# dịch trái
func move_left():
	block_present = delete_block()
	if checkmap_block_left() > 1 && check_move_left() == 0: 
		pos = pos - Vector2i(1,0)
	block_present = draw_block(block_type , pos, block_color)

# dịch phải
func move_right():
	block_present = delete_block()
	if checkmap_block_right() < 10 && check_move_right() == 0:
		pos = pos + Vector2i(1,0)
	block_present = draw_block(block_type , pos, block_color)

# kiểm tra giới hạn bên trái
func checkmap_block_left():
	var min_x = 11
	for i in block_type:
		check_pos = pos + i
		if (min_x > check_pos[0]):
			min_x = check_pos[0]
	return min_x

# kiểm tra giới hạn bên phải
func checkmap_block_right():
	var max_x = 0
	for i in block_type:
		check_pos = pos + i
		if (max_x < check_pos[0]):
			max_x = check_pos[0]
	return max_x


func check_mode():
	if(Global.set_mode == 0):
		speed = 1.0
	elif(Global.set_mode == 1):
		speed = 4.0
	else:
		speed = 10.0

#kiểm tra khối có chạm đáy hoặc khối khác không
func check_impact():
	var max_y = 0
	for i in block_type:
		check_pos = pos + i
		if (max_y < check_pos[1]):
			max_y = check_pos[1]
		if(get_cell_source_id(active_layer,check_pos+Vector2i(0, 1),false) != -1):
			return false
	if max_y <20:
		return true
	else:
		return false


#khối rơi xuống
func falling():
	block_present = delete_block()
	if check_impact():
		pos = pos + Vector2i(0,1)
		block_present = draw_block(block_type , pos, block_color)
	else:
		block_present = draw_block(block_type , pos, block_color)
		if !end_game():
			var i_line = maxy()
			var my =miny()
			while i_line >= my:
				if check_line(i_line):
					del_line(i_line)
					falling_line(i_line)
					my += 1
				else:
					i_line -= 1
			add_shape()
			update_score()
		else:
			game_running = false

#kiểm tra điểu kiện kết thúc: có đủ chỗ để vẽ khối mới vào không
func end_game():
	for i in block_type:
		check_pos = Vector2i(x_pos, y_pos) + i
		if(get_cell_source_id(active_layer,check_pos,false) != -1):
			return true
	return false

func check_line(y):
	for i in range(10):
		if(get_cell_source_id(active_layer,Vector2i(i+1, y),false) == -1):
			return false
	return true

# xóa dòng thứ Y
func del_line(y):
	for i in range(10):
		erase_cell(active_layer,Vector2i(i+1, y))
	Global.score += 100
	if Global.score >= Global.highest_score:
		Global.highest_score = Global.score



func miny():
	var min_y = 20
	for i in block_type:
		check_pos = pos + i
		if (min_y > check_pos[1]):
			min_y = check_pos[1]
	return min_y

func maxy():
	var max_y = 0
	for i in block_type:
		check_pos = pos + i
		if (max_y < check_pos[1]):
			max_y = check_pos[1]
	return max_y

func falling_line(y):
	var z = y-1
	while z >= 1:
		for i in range(10):
			set_cell(active_layer, Vector2i(i+1, z+1), get_cell_source_id(active_layer,Vector2i(i+1, z),false), Vector2i(0, 0))
			erase_cell(active_layer, Vector2i(i+1, z))
		z -= 1


