extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var minutes = 1;
export(int) var seconds = 2; 
var timeInSeconds = 0;
var points = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	timeInSeconds = (minutes*60)+seconds;
	GlobalVars.pointsBox = $".";
	pass;

func _addPoints(var p):
	points += p;
	$Points.text = "Points: " + str(points);

func getPoints(points):
	return points;

var player_name = "Stupid Idiot"

func saveScores(player_name, points):
	SilentWolf.Scores.persist_score(player_name, points)
	var score_id = yield(SilentWolf.Scores.persist_score(player_name, points), "sw_score_posted")
	print("Score persisted successfully: " + str(score_id));


func _endGame():
	$"../EndGameScreen"._endGame();


func _on_ClockTimer_timeout():
	timeInSeconds -= 1;
	var sec = timeInSeconds%60;
	var minu = (timeInSeconds/60)%60;
	$ClockTimerText.text="Remaining time:\n"+"%02d:%02d" % [minu, sec]
	if timeInSeconds == 0:
		print("There are 0 seconds on the clock")
		$ClockTimer.stop()
		saveScores(player_name, points);
		_endGame()
		
	pass # Replace with function body.
