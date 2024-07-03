extends Node


export var min_platform_speed: int

const platform01 = preload("res://scenes/Platform01.tscn")
const collectible = preload("res://scenes/CollectibleItem.tscn")
const min_distance = 600

onready var spawn_line = Position2D.new()

var platform_width = 0
var score = 0

func _ready():
	var new_platform = platform01.instance()
	platform_width = new_platform.get_node("Sprite").texture.get_width()
	
	add_child(spawn_line)
	init_platforms()

func init_platforms():
	for y in range(0, 10):
		var new_platform = create_platform(Vector2(0, -200 * y - 100))
		add_child(new_platform)

func _process(delta):
	$CanvasLayer/Control/ScoreValue.text = str(score)
	spawn_line.position.y = $Player.position.y - min_distance

func spawn_platform():
	var new_platform = create_platform(spawn_line.position)
	
	new_platform.spawn_collectible_item = !bool(randi() % 5)
	
	add_child_below_node($Platforms, new_platform)

func create_platform(plat_position: Vector2):
	var new_platform = platform01.instance()
	plat_position.x = platform_width * int(rand_range(0, 5)) + 53
	
	rand_seed(plat_position.x)
	
	new_platform.position = plat_position
	new_platform.fall_speed = min_platform_speed
	
	return new_platform

func _on_Player_jumping():
	$PlatformSpawner.stop()
	spawn_platform()
	$PlatformSpawner.start()

func _on_PlatformSpawner_timeout():
	spawn_platform()

func _on_Player_collected():
	score += 1
