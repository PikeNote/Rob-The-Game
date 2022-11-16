extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	$".".look_at(get_viewport().get_mouse_position())
	$".".rotation_degrees += 180
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			$HookItem.shoot(event.position - get_viewport().size * 0.5)
		else:
			$HookItem.release()
