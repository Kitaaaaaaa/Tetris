extends TileMap

#tetrominoes
var i_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
var i_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var i_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
var i_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var i := [i_0, i_90, i_180, i_270]

var t_0 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var t_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1)]
var t_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var t := [t_0, t_90, t_180, t_270]

var o_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o := [o_0, o_90, o_180, o_270]

var z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_90 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var z_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_270 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var z := [z_0, z_90, z_180, z_270]

var s_0 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var s_90 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s_180 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var s_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s := [s_0, s_90, s_180, s_270]

var l_0 := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var l_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var l_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1)]
var l_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var l := [l_0, l_90, l_180, l_270]

var j_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var j_90 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]
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
var block_type
var shapes_type: int 

var pos: Vector2i

var x_pos:  int = 4
var y_pos:  int = 1
var check_pos
var x_check_pos

var block_color: int

var speed: float
var time_elapsed : float =0.0

func _ready():
	game_running = true
	check_mode()
	pos = Vector2i(x_pos, y_pos)
	shapes_type =randi_range(0,6)
	current_block =randi_range(0,3)
	block_type = shapes[shapes_type][current_block]
	block_color = randf_range(4,11)
	block_present = draw_block(block_type, pos, block_color)
	pass


func _process(delta):
	time_elapsed += delta
	if(time_elapsed >= 1/speed):
		if(game_running == true):
			falling()
			time_elapsed = 0
	pass

func _input(event):
	if event.is_action_pressed("rotate"):
		rota()
	if event.is_action_pressed("move_left"):
		move_left()
	if event.is_action_pressed("move_right"):
		move_right()
	if event.is_action_pressed("move_down"):
		falling()

# vẽ khối 
func draw_block(block, pos, tile_id):
	for i in block:
		set_cell(active_layer, pos + i, tile_id, Vector2i(0,0))

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
	
	if(checkmap_block_left() < 1):
		pos = pos + Vector2i(1 - checkmap_block_left(),0)
		block_present = draw_block(block_type , pos, block_color)
	elif(checkmap_block_right() > 10):
		pos = pos - Vector2i(checkmap_block_right()-10,0)
		block_present = draw_block(block_type , pos, block_color)
	else:
		block_present = draw_block(block_type , pos, block_color)

# dịch phải
func move_left():
	if(checkmap_block_left() > 1):
			block_present = delete_block()
			pos = pos - Vector2i(1,0)
			block_present = draw_block(block_type , pos, block_color)

# dịch trái
func move_right():
	if(checkmap_block_right() < 10):
			block_present = delete_block()
			pos = pos + Vector2i(1,0)
			block_present = draw_block(block_type , pos, block_color)

# kiểm tra giới hạn bên phải
func checkmap_block_left():
	var min_x = 11
	for i in block_type:
		check_pos = pos + i
		if (min_x > check_pos[0]):
			min_x = check_pos[0]
	return min_x

# kiểm tra giới hạn bên trái
func checkmap_block_right():
	var max_x = 0
	for i in block_type:
		check_pos = pos + i
		if (max_x < check_pos[0]):
			max_x = check_pos[0]
	return max_x


func check_mode():
	if(Global.set_mode == 1):
		speed = 1.0
	elif(Global.set_mode == 2):
		speed = 4.0
	else:
		speed = 10.0

#kiểm tra khối có chạm đáy hoặc khối khác không
func check_impact():
	var max_y = 0
	for i in block_type:
		check_pos =pos + i
		if(max_y < check_pos[1]):
			max_y = check_pos[1]
	if(max_y < 20):
		return true
	else:
		return false

#di chuyển khối rơi xuống
func falling():
	if check_impact():
		block_present = delete_block()
		pos = pos + Vector2i(0,1)
		block_present = draw_block(block_type , pos, block_color)
	else:
		shapes_type = randi_range(0,6)
		current_block = randi_range(0,3)
		pos = Vector2i(x_pos, y_pos)
		block_type = shapes[shapes_type][current_block]
		block_color = randf_range(4,11)
		block_present = draw_block(block_type, pos, block_color)

#
func end_game():
	var min_y = 20
	for i in block_type:
		check_pos =pos + i
		if(min_y > check_pos[1]):
			min_y = check_pos[1]
	pass
