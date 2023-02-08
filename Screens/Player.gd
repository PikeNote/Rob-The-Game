extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var overUI = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	

func _changeOverUI(b):
	overUI = b;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if(not $Chain.visible):
		$".".look_at(get_viewport().get_mouse_position())
		$".".rotation_degrees -= 90
	
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton && GlobalVars.inventoryRef.get_node("InventorySlots")._invCount()<20 && !overUI):
		if event.pressed:
			$Chain.shoot(event.position)
		else:
			$Chain.release()

func setLinePointsToBezierCurve(line: Line2D, a: Vector2, postA: Vector2, preB: Vector2, b: Vector2):
	var curve := Curve2D.new()
	curve.add_point(a, Vector2.ZERO, postA)
	curve.add_point(b, preB, Vector2.ZERO)
	line.points = curve.get_baked_points()
