class_name HeartContainer extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		print("Heart container: +1")
		queue_free()
