extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startingY = 0;
var increasing = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Path2D/PathFollow2D".unit_offset = 0;
	startingY = $"../Path2D".transform.y;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if($"../Path2D/PathFollow2D".unit_offset<=0.95):
		$"../Path2D/PathFollow2D".unit_offset+=0.004;
		if($"../Path2D/PathFollow2D".unit_offset>=0.8):
			$"../AnimationPlayer".get_animation("JumpingRob").loop = false;
