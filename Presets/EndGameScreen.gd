extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var normalYPosition;
export var scaleUpTime:int = 0;
onready var tween = $Tween;
# Called when the node enters the scene tree for the first time.
func _ready():
	normalYPosition = $Control.rect_position.y;
	$ColorRect.visible = false;
	$Control.visible = false;
	$Control.rect_position = Vector2($Control.rect_position.x, -1000)
	
	_endGame()
	pass # Replace with function body.

func _endGame():
	#$Control.visible=true;
	tween.interpolate_property($Control, "rect_position", $Control.rect_position, Vector2($Control.rect_position.x, normalYPosition), scaleUpTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
