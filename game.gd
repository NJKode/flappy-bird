extends Node2D

@export var pipe_speed = 200

var obstacle_scn = load("res://obstacle.tscn")


func _on_pipe_respawn_timer_timeout() -> void:
	var obstacle = obstacle_scn.instantiate(pipe_speed)
	self.add_child(obstacle)


func _on_bird_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
