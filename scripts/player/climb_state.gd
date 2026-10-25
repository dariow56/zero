class_name ClimbState extends State


var is_climbing: bool = false


func enter() -> void:
	if player.animated_sprite:
		player.animated_sprite.play("climb")

 
func physics_update(_delta: float) -> void:
	# Check if the Raycast is colliding.
	var climbable = player.climb_raycast.get_collider()
	if not climbable:
		state_machine.change_state("FallState")
		return


	# Allows to jump from the grid.
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.change_state("JumpState")
		return

	# Get movement's Vector2
	var direction: Vector2  = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Add climb speed.
	if direction != Vector2.ZERO:
		player.velocity = direction * player.CLIMB_SPEED
	else:
		player.velocity = Vector2.ZERO

	player.move_and_slide()
