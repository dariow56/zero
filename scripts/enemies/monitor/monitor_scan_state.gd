class_name MonitorScanState extends State


func enter() -> void:
	actor.animated_sprite.play("fly")


func physics_update(_delta: float) -> void:
	# Update lazer and parlicles.
	actor.update_laser()

	# Flip direction if not collide on ground.
	if not actor.lazer_cast.is_colliding():
		actor.flip_direction()
	
	# Add Horizontal movement.
	actor.velocity.x = actor.direction * actor.SPEED
	actor.move_and_slide()
