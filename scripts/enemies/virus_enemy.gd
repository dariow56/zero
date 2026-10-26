class_name VirusEnemy extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_checker: RayCast2D = $WallChecker
@onready var ledge_checker: RayCast2D = $LedgeChecker
#endregion


#region /// Constants
const SPEED = 50.0
#endregion


#region /// Variables
var direction: int = -1
#endregion


func _ready() -> void:
	update_orientation()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Wall detection or ledge. 
	if is_on_wall() or wall_checker.is_colliding() or not ledge_checker.is_colliding():
		flip_direction()
	
	# Add movement.
	velocity.x = direction * SPEED
	animated_sprite.play("run")
	move_and_slide()


func flip_direction() -> void:
	# Change the direction.
	direction *= -1
	update_orientation()


func update_orientation() -> void:
	# Flip the sprite
	animated_sprite.flip_h = (direction < 0)

	# Flip the RayCast2D's
	wall_checker.target_position.x = 12.0 * direction
	wall_checker.position.x = 3.0 * direction
	ledge_checker.position.x = 5.0 * direction


func _on_hitbox_body_entered(body: Node2D) -> void:
	# Check if the colliding body has a method get damage.
	if body.has_method("get_damage"):
		body.get_damage()
		flip_direction()
