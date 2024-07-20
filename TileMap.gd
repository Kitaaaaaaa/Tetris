extends TileMap

#tetrominoes
var i_0 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
var i_90 := [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]
var i_180 := [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
var i_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var i := [i_0, i_90, i_180, i_270]

var t_0 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var t_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var t := [t_0, t_90, t_180, t_270]

var o_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o := [o_0, o_90, o_180, o_270]

var z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_90 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var z_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var z_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var z := [z_0, z_90, z_180, z_270]

var s_0 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var s_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var s_180 := [Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]
var s_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s := [s_0, s_90, s_180, s_270]

var l_0 := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var l_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var l_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]
var l_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var l := [l_0, l_90, l_180, l_270]

var j_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var j_90 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]
var j_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var j_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)]
var j := [j_0, j_90, j_180, j_270]

var shapes := [i, t, o, z, s, l, j]

#grid variables
#const COLS : int = 10
#const ROWS : int = 20

#movement variables
#const directions := [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN]
#var steps : Array
#const steps_req : int = 50
#const start_pos := Vector2i(5, 1)
#var cur_pos : Vector2i
#var speed : float
#const ACCEL : float = 0.25

#game piece variables
#var piece_type
#var next_piece_type
#var rotation_index : int = 0
#var active_piece : Array

#game variables
#var score : int
#const REWARD : int = 100
#var game_running : bool

#tilemap variables
var tile_id : int = 0
#var piece_atlas : Vector2i
#var next_piece_atlas : Vector2i

#layer variables
#var board_layer : int = 0
var active_layer : int = 3

var current_block : int = 3

var block_present
var block_present_1

var pos: Vector2i
var x_pos:  int = 1
var y_pos:  int = 1

func _ready():
	
	pos = Vector2i(x_pos, y_pos)
	block_present = draw_block(i[current_block], pos, 5)
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func draw_block(block, pos, tile_id):
	for i in block:
		set_cell(active_layer, pos + i, tile_id, Vector2i(0,0))


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
	block_present = draw_block(i[current_block], pos, 5)


func _input(event):
	if event.is_action_pressed("rotate"):
		rota()
	if event.is_action_pressed("move_left"):
		move_left()
	if event.is_action_pressed("move_right"):
		move_right()

	
func move_left():
	if( 1 < x_pos ):
			x_pos -= 1
			block_present = delete_block()
			pos = Vector2i(x_pos, y_pos)
			block_present = draw_block(i[current_block], pos, 5)


func move_right():
	if(  x_pos < 8):
			x_pos += 1
			block_present = delete_block()
			pos = Vector2i(x_pos, y_pos)
			block_present = draw_block(i[current_block], pos, 5)


func delete_block():
	for i in i[current_block]:
		erase_cell(active_layer, pos + i)


