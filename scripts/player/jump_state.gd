class_name JumpState extends State


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("jump")

	# Add vertical impulse.
	player.velocity.y = player.JUMP_VELOCITY


func physics_update(delta: float) -> void:
	# Add gravity.
	player.add_gravity(delta)

	# Horizontal movement in the air.
	player.air_movement()	

	# Start to fall if velocity in the axis y is greater than 0.
	if player.velocity.y >= 0:
		state_machine.change_state("FallState")
		return

	# Climb state.
	if player.check_climb_state():
		return
