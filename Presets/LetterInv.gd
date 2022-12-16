extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_scale(Vector2(0,0));
	print("set 0")
	pass # Replace with function body.

func _changeLetter(a):
	$Label.text = a;
func _on_Press():
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($".".rect_scale.x)
	if($Label.get_scale().x < 1):
		$Label.set_scale(Vector2($Label.get_scale().x + 0.1, $Label.get_scale().x+0.1));
