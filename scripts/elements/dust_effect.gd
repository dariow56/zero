class_name DustEffect extends AnimatedSprite2D


#region /// Object Variables
var pool: Node = null
#endregion


func _ready() -> void:
	# Connect the signal to know when the animation finished
	animation_finished.connect(on_animation_finished)


func play_effect(pos: Vector2, flip: bool = false, anim_name: String = "run_dust") -> void:
	global_position = pos
	flip_h = flip
	visible = true

	if sprite_frames.has_animation(anim_name):
		play(anim_name)
	else:
		play("run_dust")


func on_animation_finished() -> void:
	visible = false
	if pool and pool.has_method("return_instance"):
		pool.return_instance(self)
	else:
		queue_free()
