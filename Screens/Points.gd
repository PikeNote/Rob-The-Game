extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

func _addPoints(var p):
	print(str(p) + " added")
	points += p;
	$".".text = "Points: " + str(points);

func getPoints(points):
	return points;

var player_name = "Stupid Idiot"

func saveScores(player_name, points):
	SilentWolf.Scores.persist_score(player_name, points)
	var score_id = yield(SilentWolf.Scores.persist_score(player_name, points), "sw_score_posted")
	print("Score persisted successfully: " + str(score_id));

func _on_ConfirmationDialog_confirmed():
	saveScores(player_name, points);
