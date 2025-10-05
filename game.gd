extends Node2D

func _ready() -> void:
	Events.game_over.connect(_stop_game)
	_start_game()

func _start_game():
	$PipeRespawnTimer.start()

func _stop_game():
	$PipeRespawnTimer.stop()

func _on_pipe_respawn_timer_timeout() -> void:
	var obstacle = Obstacle.new()
	self.add_child(obstacle)
