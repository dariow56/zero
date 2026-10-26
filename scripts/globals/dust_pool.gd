class_name DustPool extends Node


#region /// Export Variables
@export var dust_scene: PackedScene
@export var initial_pool_size: int = 20
#endregion


#region /// Variables
var available_instances: Array[Node] = []
#endregion


func _ready() -> void:
	for i in range(initial_pool_size):
		create_new_instance()


func create_new_instance() -> Node:
	var instance = dust_scene.instantiate()
	instance.visible = false
	instance.pool = self
	add_child(instance)
	available_instances.append(instance)
	return instance

# Obtener un efecto disponible del pool
func spawn_dust(pos: Vector2, flip: bool = false, anim_name: String = "run_dust") -> void:
	var instance: Node
	
	if available_instances.size() > 0:
		instance = available_instances.pop_back()
	else:
		# Si se acaban, creamos uno extra sobre la marcha para no detener el juego
		instance = create_new_instance()
		available_instances.erase(instance)
		
	instance.play_effect(pos, flip, anim_name)

# Devolver el efecto al pool cuando termina su animación
func return_instance(instance: Node) -> void:
	instance.visible = false
	if not instance in available_instances:
		available_instances.append(instance)
