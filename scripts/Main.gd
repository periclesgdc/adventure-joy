extends Node


export var min_distance: int

const platform01 = preload("res://scenes/Platform01.tscn")

onready var spawn_line = Position2D.new()

var platform_width = 0

func _ready():
	$PlatformSpawner.start()
	
	var new_platform = platform01.instance()
	platform_width = new_platform.get_node("Sprite").texture.get_width()
	new_platform.queue_free()
	
	add_child(spawn_line)

func _on_PlatformSpawner_timeout():
	var current_y = spawn_line.position.y - min_distance
	
	spawn_platform()
	
	while spawn_line.position.y > current_y:
		spawn_line.position.y -= 100
		spawn_platform()
	
func spawn_platform():
	rand_seed(get_process_delta_time())
	
	var new_platform = platform01.instance()
	var pos_x = platform_width * (randi() % 6) + 21
	
	new_platform.position = Vector2(pos_x, spawn_line.position.y)
	new_platform.fall_speed = 100
	
	add_child_below_node($Platforms, new_platform)
