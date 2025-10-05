extends Area2D

var grass_scene = load("res://grass.tscn")
@onready var grass_tiles: Array[Sprite2D] = []
@onready var stop = false

const GRASS_SPRITE_SIZE = 128
const GRASS_TILE_SIZE = GRASS_SPRITE_SIZE * 5
const CUTOFF_X_POSITION = GRASS_TILE_SIZE * -1

func _ready() -> void:
	var grass_a: Sprite2D = grass_scene.instantiate()

	var grass_b: Sprite2D = grass_scene.instantiate()
	grass_b.position.x = GRASS_TILE_SIZE

	var grass_c: Sprite2D = grass_scene.instantiate()
	grass_c.position.x = GRASS_TILE_SIZE * 2

	grass_tiles += [grass_a, grass_b, grass_c]
	for grass_tile in grass_tiles:
		self.add_child(grass_tile)


func _process(delta: float) -> void:
	var shunt_grass = false

	for grass_tile in grass_tiles:
		grass_tile.position.x -= GameState.game_speed * delta
		shunt_grass = shunt_grass or grass_tile.position.x <= CUTOFF_X_POSITION

	if shunt_grass:
		var grass_tile_to_shunt = grass_tiles.pop_front()
		grass_tile_to_shunt.position.x = grass_tiles[-1].position.x + GRASS_TILE_SIZE
		grass_tiles += [grass_tile_to_shunt]
