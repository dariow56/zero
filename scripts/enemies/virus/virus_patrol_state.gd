class_name VirusPatrolState extends State


#region /// Export Variables
@export var patrol_time: float = 3.0
#endregion

#region /// Variables
var elapsed_time: float = 0.0
#endregion


func enter() -> void:
	actor.animated_sprite.play("run")
	elapsed_time = 0.0


func physics_update(delta: float) -> void:
	elapsed_time += delta

	# Add gravity.
	actor.add_gravity(delta)

	# Detección de paredes y abismos
	if actor.is_on_wall() or actor.wall_checker.is_colliding() or not actor.ledge_checker.is_colliding():
		actor.flip_direction()

	actor.velocity.x = actor.direction * actor.SPEED
	actor.move_and_slide()

	# Transición al estado de reposo tras cumplir el tiempo
	if elapsed_time >= patrol_time:
		state_machine.change_state("VirusIdleState")
