class_name Trampoline extends Area2D


#region /// Export Variables
@export var launch_force: float = 600
#endregion


#region /// Ready Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: CollisionShape2D = $CollisionShape2D
#endregion


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		launch_player(body)


func launch_player(body: Node2D) -> void:
	if "velocity" in body:
		body.velocity.y = -launch_force
	
	animated_sprite.play("bounce")
