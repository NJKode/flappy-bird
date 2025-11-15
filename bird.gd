extends Area2D

const MAX_HEIGHT: float = -20.0
const INITIAL_POSITION: Vector2 = Vector2(100.0, 450.0)

@export var max_fall_speed = 800
@export var acceleration = 15

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var MIN_HEIGHT = get_viewport_rect().size.y + 100

var vertical_speed: float = 0.0

func _ready() -> void:
	reset()


func _process(delta: float):
	if GameState.state != GameState.State.PLAYING:
		return

	_fall(delta)

	if (
		Input.is_action_just_pressed("flap") and
		GameState.state != GameState.State.GAME_OVER
	):
		_fly_up(delta)

	_rotate_to_speed()


func reset():
	self.rotation = 0
	self.position = INITIAL_POSITION


func _rotate_to_speed():
	rotation = (PI / 4) * (vertical_speed / max_fall_speed) - (PI / 8)


func _fall(delta: float):
	var total_acceleration = acceleration
	if position.y <= MAX_HEIGHT:
		total_acceleration += 50

	vertical_speed += total_acceleration
	vertical_speed = min(vertical_speed, max_fall_speed)
	var new_y_position = position.y + vertical_speed * delta

	position.y = clampf(new_y_position, MAX_HEIGHT, MIN_HEIGHT)


func _fly_up(_delta):
	sprite.play("flap")
	vertical_speed = -800


func _on_area_entered(area: Area2D) -> void:
	if GameState.state != GameState.State.PLAYING:
		return

	if ['Floor', 'TopPipe', 'BottomPipe'].has(area.name):
		_start_game_over_process()


func _start_game_over_process():
	vertical_speed = 0
	Events.game_over.emit()
