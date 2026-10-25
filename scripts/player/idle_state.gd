class_name IdleState extends State


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("idle")


func physics_update(delta: float) -> void:
	# Fall state
	if player.check_fall_state(delta):
		return

	# Climb state.
	# Check the RayCast2D if is near a grid or not.
	var climbable = player.climb_raycast.get_collider()

	# Get the input direction and handle the movement.
	var direction: Vector2 = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
	
	# Check climbable state
	# Start if up or down buttons are pressed when player is on the grid.
	if climbable and direction.y != 0:
		state_machine.change_state("ClimbState")
		return

	# Jump state.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		state_machine.change_state("JumpState")
		return
	
	# Run state.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x != 0:
		state_machine.change_state("RunState")
		return
	
	# Smooth braking on the ground.
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
