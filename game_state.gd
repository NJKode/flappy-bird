extends Node

enum State {
	STOPPED,
	PLAYING,
	GAME_OVER
}

var state = State.STOPPED

@export var initial_game_speed = 200

@onready var game_speed = 0

func _ready() -> void:
	Events.game_over.connect(_on_game_over)

func start_game():
	state = State.PLAYING
	game_speed = initial_game_speed

func _on_game_over():
	state = State.STOPPED
	game_speed = 0