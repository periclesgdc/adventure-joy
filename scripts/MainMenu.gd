extends Node2D



func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$TransitionScene/AnimationPlayer.play("transition")

func _on_TransitionScene_finished():
	get_tree().change_scene("res://scenes/Main.tscn")
