extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _addPoints(var p):
	points += p;
	$".".text = "Points: " + str(points);



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
