class_name ClimbState extends State


func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("climb")

 
func physics_update(_delta: float) -> void:
	# Check if the Raycast is colliding.
	if not actor.climbable:
		state_machine.change_state("FallState")
		return

	# Allows to jump from the grid.
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.change_state("JumpState")
		return

	# Add climb speed.
	if actor.direction != Vector2.ZERO:
		actor.velocity = actor.direction * actor.CLIMB_SPEED
		actor.animated_sprite.play("climb")
	else:
		actor.velocity = Vector2.ZERO
		actor.animated_sprite.pause()

	actor.move_and_slide()
