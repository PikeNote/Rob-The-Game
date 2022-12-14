extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x = 0;
var y = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".set_scale(Vector2(0,0));	
	pass # Replace with function body.

func _changeLetter(a):
	$".".text = a;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(x < 1):
		x+=.1;
		y+=.1;
		$".".set_scale(Vector2(x,y));
#	pass
