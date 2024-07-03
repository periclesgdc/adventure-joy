extends Area2D


func _on_CollectibleItem_body_entered(body):
	if body.is_in_group("player"):
		body.collect_item()
		queue_free()
