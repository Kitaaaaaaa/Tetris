extends Node2D
var block_tile = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_set= TileSet.new()
	var sprite_block = self.get_children()
	for i in range(sprite_block.size()):
		var sprite = sprite_block[i]
		var sprite_texture = sprite.texture
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = sprite_texture
		atlas_texture.region = Rect2(Vector2.ZERO,sprite_texture.get_size())
		tile_set.create_tile(i,atlas_texture.atlas,atlas_texture.region)
		print(tile_set)
	block_tile.append(tile_set)
