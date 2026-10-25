class_name FallState extends State


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("fall")


func physics_update(delta: float) -> void:
	# Add gravity.
	player.add_gravity(delta)

	# Horizontal movement in the air.
	player.air_movement()	

	# Si toca el suelo, decidimos si corre o se queda en idle
	if player.is_on_floor():
		if player.direction.x != 0:
			state_machine.change_state("RunState")
		else:
			state_machine.change_state("IdleState")
		return

	# Climb state.
	if player.check_climb_state():
		return
