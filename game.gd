extends Node2D

var ready_label: Label
var score_label: Label

var score: int = 0

func _ready() -> void:
	Events.game_over.connect(_stop_game)
	ready_label = $GameUI.get_node("ReadyLabel")
	score_label = $GameUI.get_node("ScoreLabel")


func start_game():
	ready_label.show()
	update_score(0)
	$Bird.reset()
	$GameCountdownTimer.start()


func _stop_game():
	$PipeRespawnTimer.stop()

func _on_pipe_respawn_timer_timeout() -> void:
	var obstacle = Obstacle.new()
	obstacle.score_point.connect(increase_score)
	self.add_child(obstacle)


func increase_score():
	update_score(score + 1)

func update_score(new_value: int):
	score = new_value
	score_label.text = "Score: %d" % score


func _on_game_countdown_timer_timeout() -> void:
	ready_label.hide()
	score_label.show()
	$PipeRespawnTimer.start()
	GameState.start_game()
