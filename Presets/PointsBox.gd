extends Sprite

var timeInSeconds = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	timeInSeconds = int($".".owner.get_node("GameManager").get("timeTotal"))
	GameReferences.pointsBox = $".";
	pass;

func _updatePoints():
	$Points.text = "Points: " + str(GameReferences.pointsEarned);

var player_name = UserManager.getFullUsername();

func _endGame():
	$"../EndGameScreen"._endGame();


func _on_ClockTimer_timeout():
	timeInSeconds -= 1;
	var sec = timeInSeconds%60;
	var minu = (timeInSeconds/60)%60;
	$ClockTimerText.text="Remaining time:\n"+"%02d:%02d" % [minu, sec]
	if timeInSeconds == 0:
		$ClockTimer.stop()
		_endGame()
		
	pass # Replace with function body.
