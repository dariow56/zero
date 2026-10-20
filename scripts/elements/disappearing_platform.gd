class_name DisappearingPlatform extends AnimatableBody2D


#region /// Export Variables
@export var time_before_disappear: float = 0.5
@export var time_to_respawn: float = 0.4
#endregion


#region /// Ready Variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var disappear_timer: Timer = $DisappearTimer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var detection: CollisionShape2D = $Area2D/CollisionShape2D
#endregion


func _on_area_2d_body_entered(body: Node2D) -> void:
	# check if Player triggered the platform
	if body.name == 'Player':
		start_disappear_secuence()


func start_disappear_secuence() -> void:
	# disable area detection
	detection.set_deferred("disabled", true)

	# fade out visual effect
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.3, time_before_disappear)

	# star the timer
	disappear_timer.start(time_before_disappear)


func deactivate_platform() -> void:
	sprite.visible = false
	collision.set_deferred("disabled", true)

		
func reactivate_platform() -> void:
	sprite.visible = true 
	sprite.modulate.a = 1.0 # restart the opacity
	collision.set_deferred("disabled", false)
	detection.set_deferred("disabled", false)


func _on_disappear_timer_timeout() -> void:
	# deactivate the platform
	deactivate_platform()

	# start the respawn timer
	respawn_timer.start(time_to_respawn)


func _on_respawn_timer_timeout() -> void:
	# reactivate the platform
	reactivate_platform()
