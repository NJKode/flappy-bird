extends Area2D

@export var max_vertical_speed = 800
@export var acceleration = 15

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var vertical_speed: float = 0.0

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

    if Input.is_action_pressed("flap"):
        _fly_up(delta)


    _rotate_to_speed()
