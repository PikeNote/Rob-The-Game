extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity: Vector2
var yValue = 0;

var currentPlace = 0;
var moving = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	yValue = $"../KinematicBody2D".position.y;
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity += Vector2.DOWN * 14.0 * delta;
	
	
	
	
	if(moving):
		if($"../KinematicBody2D".position.y>=yValue):
			velocity = Vector2.UP * 7.0;
		$"../Planet-transformed".rotation_degrees += 0.5;
	$"../KinematicBody2D".move_and_collide(velocity);
		

func _getCurrentPlace():
	return currentPlace;

func _moveNextLocation():
	moving = true;

func _doneMoving(index):
	print(index)
	moving = false;
	currentPlace = index;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
