extends KinematicBody2D

export var fall_speed: int

func _physics_process(delta):
	move_and_slide(Vector2(0, fall_speed), Vector2.DOWN)
	
	if position.y > 700:
		queue_free()
