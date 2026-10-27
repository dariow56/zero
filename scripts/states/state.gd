@icon("res://sprites/states/state.png")
class_name State extends Node


#region /// Export Variables
@export var actor: CharacterBody2D
#endregion 

#region /// Actor reference
var state_machine: StateMachine
#endregion


# It executes upon entering the state.
func enter() -> void:
	pass


# It executes upon exiting the state.
func exit() -> void:
	pass


# It executes on every _process().
func update(_delta: float) -> void:
	pass


# It executes on every _physics_process().
func physics_update(_delta: float) -> void:
	pass
