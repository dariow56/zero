@icon("res://sprites/states/state_machine.png")
class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func init(player: CharacterBody2D) -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = player
			child.state_machine = self
			print("Estado registrado: ", child.name.to_lower())

	if initial_state:
		current_state = initial_state
		current_state.enter()
		print("Estado inicial configurado correctamente: ", initial_state.name)
	else:
		print("¡ERROR GRAVE! El 'Initial State' en el Inspector está vacío.")


func change_state(new_state_name: String) -> void:
	print("-> Solicitud para cambiar a estado: ", new_state_name)
	
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		print("¡ERROR! No se encontró ningún nodo registrado con el nombre: ", new_state_name)
		return
		
	if new_state == current_state:
		print("Ya nos encontramos en este estado, se ignora el cambio.")
		return

	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	print("¡Éxito! Cambiado al estado: ", new_state.name)


func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
	else:
		print("¡ALERTA! current_state es NULL en physics_update.")
