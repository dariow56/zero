class_name VirusEnemy extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_checker: RayCast2D = $WallChecker
@onready var ledge_checker: RayCast2D = $LedgeChecker
@onready var state_machine: StateMachine = $StateMachine
#endregion

#region /// Constants
const SPEED = 50.0
#endregion

#region /// Variables
var direction: int = -1
#endregion


func _ready() -> void:
	update_orientation()
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	# Initialize the state machine physics update
	state_machine.physics_update(delta)	


func add_gravity(delta: float) -> void:
	velocity.y += get_gravity().y * delta


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
