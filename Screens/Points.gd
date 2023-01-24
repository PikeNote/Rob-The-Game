extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _addPoints(var p):
	print(str(p) + " added")
	points += p;
	$".".text = "Points: " + str(points);

var player_name = "Stupid Idiot"

func _saveScores(player_name, points):
	SilentWolf.Scores.persist_score(player_name, points)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
