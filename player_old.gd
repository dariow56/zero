class_name PlayerOld extends CharacterBody2D


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var climb_raycast: RayCast2D = $ClimbRayCast2D
#endregion


#region /// Constants
const SPEED = 120.0
const JUMP_VELOCITY = -320.0
const CLIMB_SPEED = 70.0
#endregion


#region /// Variables
var is_climbing: bool = false
#endregion


func _physics_process(delta: float) -> void:
	# Check the RayCast2D if is rear a grid or not.
	var climbable = climb_raycast.get_collider()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Check the climbable state
	# Start if up or down buttons are pressed when the Player is on the grid.
	if climbable:
		if not is_climbing and direction.y != 0:
			is_climbing = true
	else:
		is_climbing = false

	# Change Player's movement depends of the state.
	if is_climbing: climb(direction)
	else: movement(delta)

	# Update Player's animations
	update_animations()

	# Update Player's movement
	move_and_slide()


func climb(direction: Vector2) -> void:
	# Allows to jump from the grid.
	if Input.is_action_just_pressed("ui_accept"):
		is_climbing = false
		velocity.y = JUMP_VELOCITY * 0.7
		return

	if direction: velocity = direction * CLIMB_SPEED 
	else: velocity = Vector2.ZERO


func movement(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#$AnimatedSprite2D.play("fall")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#$AnimatedSprite2D.play("jump")

	if direction:
		velocity.x = direction * SPEED
		#$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#$AnimatedSprite2D.play("idle")


func update_animations() -> void:
	# Flip animation direction
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false

	# Update the animations depending of the state.
	if is_climbing:
		if velocity != Vector2.ZERO:
			animated_sprite.play("climb")
		else:
			animated_sprite.pause()
	else:
		if not is_on_floor():
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
		else:
			if velocity.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")

func get_damage() -> void:
	animated_sprite.play("damage")
