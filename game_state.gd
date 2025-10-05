extends Node

@export var initial_game_speed = 200

@onready var game_speed = 0

func _ready() -> void:
	Events.game_over.connect(_on_game_over)
	_start_game()

func _start_game():
	game_speed = initial_game_speed

func _on_game_over():
	game_speed = 0