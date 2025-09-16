extends Node2D

@export var pipe_speed = 200

func _ready() -> void:
	Events.game_over.connect(_stop_game)
	_start_game()

func _start_game():
	$PipeRespawnTimer.start()

func _stop_game():
	$PipeRespawnTimer.stop()

func _on_pipe_respawn_timer_timeout() -> void:
	var obstacle = Obstacle.new(pipe_speed)
	self.add_child(obstacle)
