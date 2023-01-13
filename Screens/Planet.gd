extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity: Vector2
var yValue = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	yValue = $"../KinematicBody2D".position.y;
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity += Vector2.DOWN * 7.0 * delta;
	if($"../KinematicBody2D".position.y>=yValue):
		print("pos" + str($"../KinematicBody2D".position.y));
		velocity = Vector2.UP * 7.0;
	
	$"../KinematicBody2D".move_and_collide(velocity);
	$"../Planet-transformed".rotation_degrees += 0.4;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
