extends Node


const game_over = preload("res://scenes/GameOverLabel.tscn")

onready var spawn_line = $SpawnerLayer/SpawnerPosition

var score = 0


func _on_Player_collected():
	score += 1
	$HUD.update_score(score)

func _on_Player_died():
	var game_over_label = game_over.instance()
	add_child(game_over_label)
	
	$Restarter.start()
	
	get_tree().paused = true

func _on_Restarter_timeout():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_PlatformSpawner_checkpoint(height):
	$HUD.update_height(height)
