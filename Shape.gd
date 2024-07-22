class_name Shape

extends TileMap
@export var tetro : String
@export var shape_0 := [Vector2i(),Vector2i(),Vector2i(),Vector2i()]
@export var shape_90 := [Vector2i(),Vector2i(),Vector2i(),Vector2i()]
@export var shape_180 := [Vector2i(),Vector2i(),Vector2i(),Vector2i()]
@export var shape_270 := [Vector2i(),Vector2i(),Vector2i(),Vector2i()]
var shape := [shape_0, shape_90, shape_180, shape_270]
@export var color_block : String
# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite_scene =load("res://Blocks.tscn")
	var sprite_instance = sprite_scene.instance()
	add_child(sprite_instance)
	var selected_sprite= null
	for child in sprite_instance.get_children():
		if child.name == color_block and child is Sprite2D:
			selected_sprite = child
			break
	if selected_sprite:
		pass

func rotate_shape():
	pass


func create_tileset_from_sprite(sprite: Sprite2D) -> TileSet:
	var tile_set = TileSet.new()
	var texture = sprite.texture
	var region = Rect2(Vector2.ZERO, texture.get_size())
	var tile_id = tile_set.create_tile(0)
	tile_set.tile_set_texture(tile_id, texture)
	tile_set.tile_set_region(tile_id, region)
	return tile_set
