extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var inv = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _addLetter(l):
	var letter = load("res://Presets/LetterInv.tscn").instance()
	add_child(letter);
	letter._changeLetter(l);
	inv.append(l);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
