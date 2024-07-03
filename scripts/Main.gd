extends Node


export var min_platform_speed: int

const platform01 = preload("res://scenes/Platform01.tscn")
const collectible = preload("res://scenes/CollectibleItem.tscn")
const min_distance = 600

onready var spawn_line = $SpawnerLayer/SpawnerPosition

var platform_width = 0
var score = 0
var position_seed = 0

func _ready():
	var new_platform = platform01.instance()
	platform_width = new_platform.get_node("Sprite").texture.get_width()
	
	init_platforms()

func init_platforms():
	for y in range(0, 10):
		var new_platform = create_platform(Vector2(0, -200 * y - 100))
		add_child(new_platform)


func spawn_platform():
	var new_platform = create_platform(spawn_line.position)
	
	new_platform.spawn_collectible_item = !bool(randi() % 5)
	
	add_child_below_node($Platforms, new_platform)

func create_platform(plat_position: Vector2):
	position_seed = rand_seed(OS.get_unix_time())[1]
	var new_platform = platform01.instance()
	plat_position.x = platform_width * (randi() % 5) + 53
	
	
	new_platform.position = plat_position
	new_platform.fall_speed = min_platform_speed
	
	return new_platform

func _on_PlatformSpawner_timeout():
	spawn_platform()

func _on_Player_collected():
	score += 1
	$CanvasLayer/Control/ScoreValue.text = str(score)

func _on_Player_died():
	print('died')
	$Restarter.start()
	
	get_tree().paused = true

func _on_Restarter_timeout():
	get_tree().reload_current_scene()
	get_tree().paused = false
