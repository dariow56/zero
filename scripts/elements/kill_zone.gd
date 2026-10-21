class_name KillZone extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		print("Game over!")
		$Timer.start(1)


func _on_timer_timeout() -> void:
	get_tree().call_deferred("reload_current_scene")
