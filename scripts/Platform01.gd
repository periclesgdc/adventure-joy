extends KinematicBody2D

const collectible_item = preload("res://scenes/CollectibleItem.tscn")

export var fall_speed: int
export var spawn_collectible_item: bool


func _ready():
	if spawn_collectible_item:
		var new_item = collectible_item.instance()
		$ItemSlot.add_child(new_item)

func _physics_process(delta):
	move_and_slide(Vector2(0, fall_speed), Vector2.DOWN)
	
	if position.y > 700:
		queue_free()
