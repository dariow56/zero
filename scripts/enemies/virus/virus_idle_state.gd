class_name VirusIdleState extends State


#region /// Export Variables
@export var idle_time: float = 1.5 
#endregion

#region /// Variables
var elapsed_time: float = 0.0
#endregion


func enter() -> void:
	actor.animated_sprite.play("idle")
	elapsed_time = 0.0


func physics_update(delta: float) -> void:
	elapsed_time += delta

	# Add gravity.
	actor.add_gravity(delta)
	actor.velocity.x = 0.0
	actor.move_and_slide()

	# Transición al estado de patrulla tras cumplir el tiempo
	if elapsed_time >= idle_time:
		state_machine.change_state("PatrolState")
