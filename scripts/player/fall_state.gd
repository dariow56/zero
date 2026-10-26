class_name FallState extends State


func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("fall")


func physics_update(delta: float) -> void:
	# Add gravity.
	actor.add_gravity(delta)

	# Horizontal movement in the air.
	actor.air_movement()	

	# Si toca el suelo, decidimos si corre o se queda en idle
	if actor.is_on_floor():
		if actor.direction.x != 0:
			state_machine.change_state("RunState")
		else:
			state_machine.change_state("IdleState")
		return

	# Climb state.
	if actor.check_climb_state():
		return
