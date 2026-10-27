class_name MonitorEnemy extends CharacterBody2D

#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var lazer_cast: RayCast2D = $RayCast2D
@onready var line_2d: Line2D = $Line2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var state_machine: StateMachine = $StateMachine
#endregion

#region /// Constants
const SPEED = 50.0
#endregion

#region /// Variables
var direction: int = -1
#endregion


func _ready() -> void:
	line_2d.clear_points()
	line_2d.add_point(Vector2.ZERO)
	line_2d.add_point(Vector2.ZERO)
	
	update_orientation()
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	# Inicializamos la máquina de estados
	state_machine.physics_update(delta)


# Enemy helper methods
func update_laser() -> void:
	var end_point: Vector2 = lazer_cast.target_position

	if lazer_cast.is_colliding():
		end_point = to_local(lazer_cast.get_collision_point())
		
		var collider = lazer_cast.get_collider()
		if collider and collider.has_method("get_damage"):
			collider.get_damage()
	
	# Update the visual laser to the ground.
	line_2d.set_point_position(1, end_point)

	# Add particles on the impact point.
	particles.position = end_point
	particles.emitting = lazer_cast.is_colliding()


func flip_direction() -> void:
	direction *= -1
	update_orientation()


func update_orientation() -> void:
	animated_sprite.flip_h = (direction < 0)
	# Si tu RayCast2D necesita voltearse horizontalmente según la dirección, puedes descomentar la siguiente línea:
	# lazer_cast.scale.x = direction


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("get_damage"):
		body.get_damage()
