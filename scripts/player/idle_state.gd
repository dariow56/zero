class_name IdleState extends State


func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("idle")


func physics_update(delta: float) -> void:
	# Fall state
	if actor.check_fall_state(delta):
		return

	# Climb state.
	if actor.check_climb_state():
		return

	# Jump state.
	if actor.check_jump_state():
		return
	
	# Run state.
	if actor.check_run_state():
		return
	
	# Smooth braking on the ground.
	actor.velocity.x = move_toward(actor.velocity.x, 0, actor.SPEED)
	actor.move_and_slide()
