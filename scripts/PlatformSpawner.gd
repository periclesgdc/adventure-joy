extends Node


export var min_platform_speed: int

const platform01 = preload("res://scenes/Platform01.tscn")
const platform_width = 64
const min_distance = 200

signal checkpoint(height)

func randomize_spawner_position():
	randomize()
	var random_value = randi()
	seed(random_value)
	
	return platform_width * (random_value % 5) + 53

func create_platform(plat_position: Vector2):
	var new_platform = platform01.instance()
	
	new_platform.position = plat_position
	new_platform.fall_speed = min_platform_speed
	
	return new_platform

func spawn():
	var spawn_line = $SpawnerLayer
	var spawn_position = Vector2(randomize_spawner_position(), spawn_line.position.y)
	
	var new_platform = create_platform(spawn_position)
	new_platform.spawn_collectible_item = !bool(randi() % 5)
	
	add_child_below_node($Platforms, new_platform)

func get_height():
	return int(abs($SpawnerLayer.position.y) / 20)
	
func _on_SpawnerLayer_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("checkpoint", get_height())
		$PlatformTimer.stop()
		for y in range(0, 5):
			spawn()
			$SpawnerLayer.position.y -= min_distance
		spawn()
		$PlatformTimer.start()

func _on_PlatformTimer_timeout():
	spawn()
