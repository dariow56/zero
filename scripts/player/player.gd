class_name Player extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var climb_raycast: RayCast2D = $ClimbRayCast2D
@onready var floor_raycast: RayCast2D = $FloorRayCast2D
@onready var state_machine: StateMachine = $StateMachine
@onready var stand_collision: CollisionShape2D = $StandCollision
@onready var crouch_collision: CollisionShape2D = $CrouchCollision
#endregion


#region /// Variables
var direction: Vector2 = Vector2.ZERO
var climbable
var camera
#endregion


#region /// Constants
const SPEED = 120.0
const JUMP_VELOCITY = -320.0
const CLIMB_SPEED = 70.0
const CROUCH_SPEED = 60.0
#endregion


func _ready() -> void:
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement.
	direction = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")

	# Check the RayCast2D if is near a grid or not.
	climbable = climb_raycast.get_collider()
	camera = get_viewport().get_camera_2d()
	# Initialize the state machine physics update
	state_machine.physics_update(delta)	


# Check the states
func check_fall_state(delta: float) -> bool:
	if not is_on_floor():
		velocity += get_gravity() * delta
		state_machine.change_state("FallState")
		return true
	return false


func check_run_state() -> bool:
	if direction.x != 0:
		state_machine.change_state("RunState")
		return true
	return false


func check_jump_state() -> bool:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		state_machine.change_state("JumpState")
		return true
	return false
	

func check_climb_state() -> bool:
	# Check climbable state
	# Start if up or down buttons are pressed when player is on the grid.
	if climbable and direction.y != 0:
		state_machine.change_state("ClimbState")
		return true
	return false


func check_idle_state() -> bool:
	if direction.x == 0:
		state_machine.change_state("IdleState")
		return true
	return false


func check_crouch_state() -> bool:
	if direction.y > 0 and is_on_floor():
		state_machine.change_state("CrouchState")
		return true
	return false


# Player methods
func add_gravity(delta: float) -> void:
	velocity.y += get_gravity().y * delta


func air_movement() -> void:
	if direction.x != 0:
		velocity.x = direction.x * SPEED
		if animated_sprite:
			animated_sprite.flip_h = direction.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func crouch_movement(dir: float) -> void:
	if dir != 0:
		velocity.x = dir * CROUCH_SPEED
		if animated_sprite:
			animated_sprite.flip_h = (dir < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, CROUCH_SPEED)

	move_and_slide()


func set_crouch_collision(is_crouching: bool) -> void:
	if stand_collision and crouch_collision:
		stand_collision.set_deferred("disabled", is_crouching)
		crouch_collision.set_deferred("disabled", not is_crouching)

func is_on_one_way_platform() -> bool:
	if floor_raycast.is_colliding():
		return true
	return false


func drop_through_platform() -> void:
	# Move player 2px down to through the platfom and give him a few
	# vertical impulse to avoid the floor snap
	position.y += 2
	velocity.y = 10


func get_damage() -> void:
	state_machine.change_state("DamageState")
