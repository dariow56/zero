class_name RunState extends State

func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("run")
	

func physics_update(delta: float) -> void:
	# Fall state
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		state_machine.change_state("FallState")
		return

	# Climb state.
	var climbable = player.climb_raycast.get_collider()
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if climbable and direction_y != 0:
		state_machine.change_state("ClimbState")
		return

	# Jump state.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		state_machine.change_state("JumpState")
		return
	
	# Idle state.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x == 0:
		state_machine.change_state("IdleState")
		return
	
	# Add player speed.
	player.velocity.x = direction_x * player.SPEED
	if player.animated_sprite:
		player.animated_sprite.flip_h = direction_x < 0

	player.move_and_slide()
