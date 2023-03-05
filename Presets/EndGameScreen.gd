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
	for n in GameReferences.wordsSpelled:
		var wordSpelled = statWord.instance();
		wordSpelled.text = n;
		$Control/ScrollContainer/WordsSpelledContainer.add_child(wordSpelled);
	$Control/WordsSpelled.text="Words Spelled: " + str(GameReferences.wordsSpelled.size());
	$Control/PointsEarned.text="Points Spelled: " + str(GameReferences.pointsEarned);
	$".".visible = true;
	tween.interpolate_property($Control, "rect_position", $Control.rect_position, Vector2($Control.rect_position.x, normalYPosition), scaleUpTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ExitButton_pressed():
	GameReferences.endGame = true;
	$"../Transition".transition_in("res://Screens/TravelInProgress.tscn")
	pass # Replace with function body.
