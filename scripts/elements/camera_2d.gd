extends Camera2D

@export var random_strength: float = 4.0  # Intensidad del temblor en píxeles
@export var shake_duration: float = 0.15  # Duración total del temblor en segundos

var original_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	original_offset = offset

func shake() -> void:
	var elapsed = 0.0
	while elapsed < shake_duration:
		# Genera un desplazamiento aleatorio sutil dentro del rango de 1 bit
		offset = original_offset + Vector2(
			randf_range(-random_strength, random_strength),
			randf_range(-random_strength, random_strength)
		)
		elapsed += get_process_delta_time()
		await get_tree().process_frame
	
	# Regresa la cámara a su posición original exacta
	offset = original_offset
