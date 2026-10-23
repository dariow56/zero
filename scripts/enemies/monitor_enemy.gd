class_name MonitorEnemy extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var lazer_cast: RayCast2D = $RayCast2D
@onready var line_2d: Line2D = $Line2D
@onready var particles: GPUParticles2D = $GPUParticles2D
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

func _physics_process(_delta: float) -> void:
	var end_point: Vector2 = lazer_cast.target_position

	if lazer_cast.is_colliding():
		end_point = to_local(lazer_cast.get_collision_point())
		
		var collider = lazer_cast.get_collider()
		if collider and collider.has_method("die"):
			collider.die()
	
	# Update the visual lazer to the ground.
	line_2d.set_point_position(1, end_point)

	# Add particles on the impact point.
	particles.position = end_point
	
	# Activate the particles when the lazer is collide.
	particles.emitting = lazer_cast.is_colliding()

	if not lazer_cast.is_colliding():
		flip_direction()
	
	# Add movement.
	velocity.x = direction * SPEED
	move_and_slide()


func flip_direction() -> void:
	# Change the direction.
	direction *= -1
	update_orientation()

func update_orientation() -> void:
	# Flip the sprite
	animated_sprite.flip_h = (direction < 0)
