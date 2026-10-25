class_name Player extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var climb_raycast: RayCast2D = $ClimbRayCast2D
@onready var state_machine: StateMachine = $StateMachine
#endregion


#region /// Variables
var direction: Vector2 = Vector2.ZERO
#endregion


#region /// Constants
const SPEED = 120.0
const JUMP_VELOCITY = -320.0
const CLIMB_SPEED = 70.0
#endregion


func _ready() -> void:
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement.
	direction = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
	state_machine.physics_update(delta)	


func check_fall_state(delta: float) -> bool:
	if not is_on_floor():
		velocity += get_gravity() * delta
		state_machine.change_state("FallState")
		return true
	return false


func get_damage() -> void:
	state_machine.change_state("DamageState")
