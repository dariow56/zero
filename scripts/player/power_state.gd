class_name PowerState extends State

func enter() -> void:
	# Play the animation.
	if actor.animated_sprite:
		actor.animated_sprite.play("powerup")
	
	# Shake the camera.
	if actor.camera and actor.camera.has_method("shake"):
		actor.camera.shake()

func physics_update(delta: float) -> void:
	# Add gravity.
	if not actor.is_on_floor():
		actor.add_gravity(delta)
		actor.move_and_slide()
	
	# Wait until animation is finished.
	if actor.animated_sprite.is_playing() and actor.animated_sprite.animation == "powerup":
		return

	# Fall state.
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
