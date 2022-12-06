extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var letter = load("res://Presets/Letters.tscn").instance()
	add_child(letter);
	letter._changeLetter("z");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
