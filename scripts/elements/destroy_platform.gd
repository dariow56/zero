class_name DestroyPlatform extends StaticBody2D


#region /// Ready Variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
#endregion


#region /// Variables
var time = 1
#endregion


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time += 1
	$Sprite2D.position += Vector2(0, sin(time)*0.5)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		set_process(true)
		$Timer.start(0.7)



func _on_timer_timeout() -> void:
	queue_free()
