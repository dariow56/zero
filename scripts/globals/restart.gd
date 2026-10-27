extends Node

func _unhandled_input(event: InputEvent) -> void:
    # Reinicia la escena actual cargando el archivo de forma limpia y segura
    if event.is_action_pressed("restart"):
        get_tree().call_deferred("change_scene_to_file", get_tree().current_scene.scene_file_path)
