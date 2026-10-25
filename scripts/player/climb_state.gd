class_name ClimbState extends State


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("climb")

 
func physics_update(_delta: float) -> void:
	# Check if the Raycast is colliding.
	if not player.climbable:
		state_machine.change_state("FallState")
		return

	# Allows to jump from the grid.
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.change_state("JumpState")
		return

	# Add climb speed.
	if player.direction != Vector2.ZERO:
		player.velocity = player.direction * player.CLIMB_SPEED
		player.animated_sprite.play("climb")
	else:
		player.velocity = Vector2.ZERO
		player.animated_sprite.pause()

	player.move_and_slide()
