extends Control

onready var scenes = $Scenes
export var transitionNext = "";

var text = "";
var frameList = [];
var currentFrame = 0;
var typing = false;
var characterLen = 1;

func _ready():
	for n in scenes.get_children():
		var textNode = n.get_node("ScrollText");
		n.visible = false;
		frameList.append(textNode);
		textNode.visible = false;
	scenes.get_child(0).visible = true;
#
func _input(event):
	if(event is InputEventMouseButton and event.pressed and event.button_index==BUTTON_LEFT):
		if(typing):
			$TypingTimer.stop();
			frameList[currentFrame].text = text;
			typing = false;
		else:
			if(currentFrame < frameList.size()-1):
				currentFrame += 1;
				prepareFrame();
			else:
				$Transition.transition_in(transitionNext);

func prepareFrame():
	characterLen = 1;
	typing = true;
	text = frameList[currentFrame].text;
	frameList[currentFrame].text = "";
	frameList[currentFrame].visible = true;
	
	if(currentFrame == 0):
		$TypingTimer.start();
	else:
		_tweenFrame();

func _on_TypingTimer_timeout():
	if(characterLen <= text.length()):
		frameList[currentFrame].text = text.substr(0, characterLen)
		characterLen += 1;
	else:
		$TypingTimer.stop();
		typing = false;

func _tweenFrame():
	var frame = scenes.get_child(currentFrame);
	$Tween.interpolate_property(frame, "modulate", 
	  Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.0, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	frame.visible = true;
	$Tween.start();
	

func _on_Transition_transition_out_done():
	prepareFrame();
	pass # Replace with function body.


func _on_Tween_tween_completed(object, key):
	$TypingTimer.start();
