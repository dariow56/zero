class_name PlayerCrouchState extends State


func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("crouch")
	
	actor.set_crouch_collision(true)


func exit() -> void:
	actor.set_crouch_collision(false)


func physics_update(delta: float) -> void:
	actor.add_gravity(delta)
	actor.crouch_movement(actor.direction.x)

	if not Input.is_action_pressed("ui_down"):
		if actor.direction.x != 0:
			state_machine.change_state("RunState")
		else:
			state_machine.change_state("IdleState")
		return


	# Fall State.
	if not actor.is_on_floor():
		state_machine.change_state("FallState")
		return
