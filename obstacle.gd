class_name Obstacle extends Node2D
 
@export var pipe_spacing: float = 300

var pipe = load("res://pipe.tscn")
const PIPE_VERTICAL_PADDING = 20

@onready var top_pipe: Area2D = pipe.instantiate()
@onready var bottom_pipe: Area2D = pipe.instantiate()
@onready var screen_size = get_viewport_rect().size

var speed = 200

func _init(initial_speed: int) -> void:
	speed = initial_speed

func _ready() -> void:
	Events.game_over.connect(_on_game_over)

	var initial_x_position = screen_size.x + 50
	self.position.x = initial_x_position

	var pipe_length = screen_size.y
	var half_pipe_length = pipe_length / 2

	var top_pipe_lower_y_limit = half_pipe_length - pipe_spacing - PIPE_VERTICAL_PADDING
	var top_pipe_upper_y_limit = PIPE_VERTICAL_PADDING - half_pipe_length

	var top_pipe_y = randi_range(top_pipe_lower_y_limit, top_pipe_upper_y_limit)
	var bottom_pipe_y = top_pipe_y + pipe_length + pipe_spacing

	top_pipe.position = Vector2(0, top_pipe_y)
	bottom_pipe.position = Vector2(0, bottom_pipe_y)

	self.add_child(top_pipe)
	self.add_child(bottom_pipe)

func _on_game_over():
	speed = 0

func _process(delta: float) -> void:
	position.x -= speed * delta

	if position.x <= -50:
		self.queue_free()
