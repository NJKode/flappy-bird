extends Node2D

func _ready() -> void:
	Events.game_over.connect(_stop_game)


func start_game():
	$ReadyLabel.show()
	$Bird.reset()
	$GameCountdownTimer.start()


func _stop_game():
	$PipeRespawnTimer.stop()

func _on_pipe_respawn_timer_timeout() -> void:
	var obstacle = Obstacle.new()
	self.add_child(obstacle)


func _on_game_countdown_timer_timeout() -> void:
	$ReadyLabel.hide()
	$PipeRespawnTimer.start()
	GameState.start_game()
