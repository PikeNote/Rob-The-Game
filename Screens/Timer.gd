extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout",self,"_spawn_letter")
	$".".start();
	pass # Replace with function body.


func _spawn_letter():
	var letter = load("res://Presets/Letters.tscn").instance()
	$Path2D.add_child(letter);
	letter._changeLetter(letters[randi()% len(letters)]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
