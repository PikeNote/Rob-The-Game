extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_scale(Vector2(0,0));
	print("Scale set");
	pass # Replace with function body.

func _changeLetter(a):
	$Label.text = a;
	
func _on_Press():
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_scale().x);
	if(get_scale().x < 1):
		set_scale(Vector2(get_scale().x+0.01,get_scale().x+0.01));
