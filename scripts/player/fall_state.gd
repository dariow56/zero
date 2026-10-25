class_name FallState extends State

func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("fall")

func physics_update(delta: float) -> void:
	# Aplicar gravedad
	player.velocity.y += player.get_gravity().y * delta

	# Movimiento horizontal mientras cae
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x != 0:
		player.velocity.x = direction_x * player.SPEED
		if player.animated_sprite:
			player.animated_sprite.flip_h = direction_x < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

	player.move_and_slide()

	# Si toca el suelo, decidimos si corre o se queda en idle
	if player.is_on_floor():
		if direction_x != 0:
			state_machine.change_state("RunState")
		else:
			state_machine.change_state("IdleState")
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
