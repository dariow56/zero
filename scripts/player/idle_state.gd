class_name IdleState extends State


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("idle")


func physics_update(delta: float) -> void:
	# Fall state
	if player.check_fall_state(delta):
		return

	# Climb state.
	if player.check_climb_state():
		return

	# Jump state.
	if player.check_jump_state():
		return
	
	# Run state.
	if player.check_run_state():
		return
	
	# Smooth braking on the ground.
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
