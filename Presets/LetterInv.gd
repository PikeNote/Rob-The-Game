extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".rect_scale = Vector2(0,0)
	
	pass # Replace with function body.

func _changeLetter(a):
	$Label.text = a;
	
func _on_Press():
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(get_scale().x < 1):
		$".".rect_scale = Vector2(rect_scale.x + 0.0001, rect_scale.y+0.001);
