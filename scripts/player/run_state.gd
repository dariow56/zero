class_name RunState extends State

func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("run")
	

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

	# Idle state.
	if actor.check_idle_state():
		return
	
	# Add actor speed.
	actor.velocity.x = actor.direction.x * actor.SPEED
	if actor.animated_sprite:
		actor.animated_sprite.flip_h = actor.direction.x < 0

	actor.move_and_slide()
