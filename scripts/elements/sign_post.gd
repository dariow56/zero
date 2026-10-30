class_name SignPost extends Area2D

#region /// Export Variables
@export var image_texture: Texture2D 
#endregion

#region /// Ready Variables
@onready var label: Sprite2D = $SpriteLabel
@onready var hint_box: Sprite2D = $HintBox
#endregion

#region /// Variables
var player_in_range: bool = false
#endregion

func _ready() -> void:
	player_in_range = false

	if label:
		label.visible = false
	
	if hint_box:
		hint_box.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		# Show the local dialog box.
		if hint_box:
			hint_box.visible = not hint_box.visible
			if hint_box.visible and image_texture:
				hint_box.texture = image_texture


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		player_in_range = true

		if label:
			label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		player_in_range = false

		if label:
			label.visible = false
		
		if hint_box:
			hint_box.visible = false
