class_name RunState extends State

func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("run")
	

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

	# Idle state.
	if player.check_idle_state():
		return
	
	# Add player speed.
	player.velocity.x = player.direction.x * player.SPEED
	if player.animated_sprite:
		player.animated_sprite.flip_h = player.direction.x < 0

	player.move_and_slide()
