class_name Pipe extends Area2D

func _init(start_position: Vector2) -> void:
    self.position = start_position

func _ready() -> void:
    print(position)