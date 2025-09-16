extends Node2D

@export var pipe_speed = 200


func _on_pipe_respawn_timer_timeout() -> void:
	var obstacle = Obstacle.new(pipe_speed)
	self.add_child(obstacle)


func _on_bird_hit_pipe() -> void:
	print("Game over")
	pass # Replace with function body.
