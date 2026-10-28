class_name XploitEnemy extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_checker: RayCast2D = $WallChecker
@onready var ledge_checker: RayCast2D = $LedgeChecker
@onready var state_machine: StateMachine = $StateMachine
#endregion

#region /// Constants
const SPEED: float = 70.0
const CAUTION: float = 75.0
const WARNING: float = 50.0
const DANGER: float = 25.0
#endregion

#region /// Variables
var direction: int = -1
@export var player: CharacterBody2D
#endregion


func _ready() -> void:
	if not player:
		# Busca el primer nodo que esté en el grupo "Player"
		player = get_tree().get_first_node_in_group("Player")
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
	wall_checker.position.x = 5.0 * direction
	ledge_checker.position.x = 5.0 * direction


func _on_hitbox_body_entered(body: Node2D) -> void:
	# Check if the colliding body has a method get damage.
	if body.has_method("get_damage"):
		body.get_damage()
		flip_direction()


func update_danger_color(distance: float) -> void:
	if not animated_sprite:
		return

	if distance <= DANGER:
		animated_sprite.modulate = Color("e43b44")
	elif distance <= WARNING:
		animated_sprite.modulate = Color("f77622")
	elif distance <= CAUTION:
		animated_sprite.modulate = Color("fee761")
	else:
		animated_sprite.modulate = Color.WHITE
