extends Node

@onready var title_screen = $TitleScreen
@onready var game_over_screen = $GameOver


func _ready() -> void:
	var button: BaseButton = title_screen.get_node("StartGame")
	var reset_button: BaseButton = game_over_screen.get_node("Restart")
	button.pressed.connect(_on_start_game)
	reset_button.pressed.connect(_reset_game)
	Events.game_over.connect(_on_game_over)


func _on_game_over():
	game_over_screen.show()
 

func _reset_game() -> void:
	Events.reset_game.emit()
	_on_start_game()

func _on_start_game() -> void:
	title_screen.hide()
	game_over_screen.hide()
	GameState.start_countdown()
	$Game.start_game()
