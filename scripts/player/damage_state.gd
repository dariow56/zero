class_name DamageState extends State


func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("damage")


func physics_update(delta: float) -> void:
	# Add gravity.
	if not actor.is_on_floor():
		actor.add_gravity(delta)
		actor.move_and_slide()
	
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

	# Idle state.
	if actor.check_idle_state():
		return 		
