class_name DamageState extends State


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("damage")


func physics_update(delta: float) -> void:
	# Add gravity.
	if not player.is_on_floor():
		player.add_gravity(delta)
		player.move_and_slide()
	
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

	# Idle state.
	if player.check_idle_state():
		return 		
