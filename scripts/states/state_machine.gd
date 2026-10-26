@icon("res://sprites/states/state_machine.png")
class_name StateMachine extends Node


#region /// Export Variables
@export var initial_state: State
#endregion


#region /// State Variables 
var current_state: State
var states: Dictionary = {}
#endregion


func init(actor: CharacterBody2D) -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.actor = actor
			child.state_machine = self

	if initial_state:
		current_state = initial_state
		current_state.enter()


func change_state(new_state_name: String) -> void:
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		print("ERROR! State does not exist: ", new_state_name)
		return
		
	if new_state == current_state:
		return

	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()


func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
