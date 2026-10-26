class_name JumpState extends State


func enter() -> void:
	if actor.animated_sprite:
		actor.animated_sprite.play("jump")

	# Add vertical impulse.
	actor.velocity.y = actor.JUMP_VELOCITY

	# Add jump dust when jump.
	DustManager.spawn_dust(actor.global_position + Vector2(0, -8), actor.animated_sprite.flip_h, "jump_dust")


func physics_update(delta: float) -> void:
	# Add gravity.
	actor.add_gravity(delta)

	# Horizontal movement in the air.
	actor.air_movement()	

	# Start to fall if velocity in the axis y is greater than 0.
	if actor.velocity.y >= 0:
		state_machine.change_state("FallState")
		return

	# Climb state.
	if actor.check_climb_state():
		return
