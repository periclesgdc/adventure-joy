extends Node2D

const scale_values = [0.8, 1]
var scale_index = 0

func _draw():
	var color = Color(1.0, 1.0, 1.0)
	var angle_from = 0
	var angle_to = 360
	
	for i in range(0, 7):
		randomize()
		var rand_x = randi() % 3 - 1
		var center = Vector2(10 * i, 20 + 4 * i * rand_x)
		var radius = 10 + 5 * i
		
		draw_circle_arc_poly(center, radius, angle_from, angle_to, color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points+1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func _on_Translate_timeout():
	if position.x > 600:
		position.x = 0

	position.x += 15
	scale.x = scale_values[scale_index]
	
	scale_index = (scale_index + 1) % scale_values.size()
