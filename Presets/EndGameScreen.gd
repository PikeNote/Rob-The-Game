extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var normalYPosition;
export var scaleUpTime:int = 1;
onready var tween = $Tween;
const statWord = preload("res://Presets/StatWord.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	normalYPosition = $Control.rect_position.y;
	$".".visible = false;
	$Control.rect_position = Vector2($Control.rect_position.x, 1000)
	
	pass # Replace with function body.

func _endGame():
	var wordsSpelled = 0;
	var pointsEarned = GameReferences.pointsEarned;
	for n in GameReferences.wordsSpelled:
		var wordSpelled = statWord.instance();
		wordSpelled.text = n;
		$Control/ScrollContainer/WordsSpelledContainer.add_child(wordSpelled);
		wordsSpelled+=1;
	
	
	
	$Control/WordsSpelled.text="Words Spelled: " + str(wordsSpelled);
	$Control/PointsEarned.text="Points Spelled: " + str(pointsEarned);
	
	var currentScene = GameReferences.currentScene;
	
	var requiredWordSpelled = GameParameters.levelDescription[currentScene].Requirements.spelled;
	var requiredPointsGained = GameParameters.levelDescription[currentScene].Requirements.points;
	var levelName = GameParameters.levelDescription[GameReferences.currentScene].Name;
	
	# Check if the requirees for the level are met before passing/failing
	if(wordsSpelled >= requiredWordSpelled && pointsEarned >= requiredPointsGained):
		$Control/LevelStatus.text = "Level Passed!"
		$Control/LevelStatus.set("custom_colors/default_color", Color(32,255,0));
		
		if(!(levelName in UserManager.settings.levelsCompleted)):
			UserManager.settings.levelsCompleted.append(levelName);
			UserManager.updateFile();
			
		# Only add scores to the leaderboard if they passed the level
		if(UserManager.settings.saveScores):
			saveScores();
	else:
		$Control/LevelStatus.text = "Level Failed!"
		$Control/LevelStatus.set("custom_colors/default_color", Color(225,44,39));
	
	$".".visible = true;
	tween.interpolate_property($Control, "rect_position", $Control.rect_position, Vector2($Control.rect_position.x, normalYPosition), scaleUpTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
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
	$"../Transition".transition_in("res://Screens/TravelInProgress.tscn")
	pass # Replace with function body.


func _on_RestartButton_pressed():
	GameReferences.endGame = false;
	$"../Transition".transition_in("res://Screens/TravelInProgress.tscn");
