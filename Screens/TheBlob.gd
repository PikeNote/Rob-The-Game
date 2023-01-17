extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nextScale = 1;
var rng;
var increasing = true;
# Called when the node enters the scene tree for the first time.
func _init():
	nextScale = rand_range(1.2, 1.3);
	pass # Replace with function body.

func _physics_process(delta):
	if($TheBlob.scale.y < nextScale && increasing):
		$TheBlob.scale = Vector2($TheBlob.scale.x, $TheBlob.scale.y + .015)
	elif($TheBlob.scale.y > 1):
		increasing = false;
		$TheBlob.scale = Vector2($TheBlob.scale.x, $TheBlob.scale.y - .015);
	else:
		increasing = true;
		nextScale = rand_range(1.2, 1.3);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
