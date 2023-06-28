extends Node2D

var normalYPosition;
export var scaleUpTime:int = 1;
onready var tween = $Tween;
const statWord = preload("res://Presets/StatWord.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	normalYPosition = $CanvasLayer/Control.rect_position.y;
	$CanvasLayer.visible = false;
	$CanvasLayer/Control.rect_position = Vector2($CanvasLayer/Control.rect_position.x, 1000)
	
	pass # Replace with function body.

func _endGame():
	var wordsSpelled = 0;
	var pointsEarned = GameReferences.pointsEarned;
	for n in GameReferences.wordsSpelled:
		var wordSpelled = statWord.instance();
		wordSpelled.text = n;
		$CanvasLayer/Control/ScrollContainer/WordsSpelledContainer.add_child(wordSpelled);
		wordsSpelled+=1;
	
	
	
	$CanvasLayer/Control/WordsSpelled.text="Words Spelled: " + str(wordsSpelled);
	$CanvasLayer/Control/PointsEarned.text="Points Spelled: " + str(pointsEarned);
	
	
	MultiplayerWebsocket._endGame(pointsEarned);

func multiplayerReults(p):
	var opPlayer = 1;
	if(MultiplayerWebsocket.player == 1):
		opPlayer = 0;
	$CanvasLayer/Control/EnemyPoints.text="Enemy Points: " + str(p["scores"][opPlayer]);
	print("Winner: " + str(p["winner"]))
	if(p["winner"] == MultiplayerWebsocket.player):
		$CanvasLayer/Control/LevelStatus.text = "You won!";
		$CanvasLayer/Control/LevelStatus.set("custom_colors/default_color", Color("#20FF00"));
	elif(p["winner"] == -1):
		$CanvasLayer/Control/LevelStatus.text = "You drew!";
		$CanvasLayer/Control/LevelStatus.set("custom_colors/default_color", Color("#FFEA00"));
	else:
		$CanvasLayer/Control/LevelStatus.text = "You lost!";
		$CanvasLayer/Control/LevelStatus.set("custom_colors/default_color", Color("#E12C27"));
	
	showScreen();

func showScreen():
	$CanvasLayer.visible = true;
	tween.interpolate_property($CanvasLayer/Control, "rect_position", $CanvasLayer/Control.rect_position, Vector2($CanvasLayer/Control.rect_position.x, normalYPosition), scaleUpTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start();
	

func saveScores():
	var pointsEarned = GameReferences.pointsEarned
	var username = UserManager.getFullUsername();
	var levelName = GameParameters.levelDescription[GameReferences.currentScene].Name;
	
	var metadata = {
		"modifiers": UserManager.settings.modifiers
	}
	SilentWolf.Scores.persist_score(username, pointsEarned, levelName, metadata);

func _on_ExitButton_pressed():
	GameReferences.endGame = true;
	$"../Transition".transition_in("res://Screens/MainScene.tscn")
	pass # Replace with function body.
