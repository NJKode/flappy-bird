extends Area2D

@export var max_vertical_speed = 800
@export var acceleration = 15

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var vertical_speed: float = 0.0
var game_over = false

func _fall(delta: float):
	vertical_speed += acceleration
	vertical_speed = min(vertical_speed, max_vertical_speed)
	position.y += vertical_speed * delta

func _rotate_to_speed():
	rotation = (PI / 4) * (vertical_speed / max_vertical_speed) - (PI / 8)

func _fly_up(_delta):
	sprite.play("flap")
	vertical_speed = -800

func _process(delta: float):
	_fall(delta)

	if Input.is_action_just_pressed("flap") and not game_over:
		_fly_up(delta)

	_rotate_to_speed()


func _on_area_entered(area: Area2D) -> void:
	if game_over:
		return

	if ['TopPipe', 'BottomPipe'].has(area.name):
		_start_game_over_process()


func _start_game_over_process():
	game_over = true
	vertical_speed = 0
	Events.game_over.emit()
