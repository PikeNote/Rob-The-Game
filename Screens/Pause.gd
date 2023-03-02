extends Node2D

onready var _tpm = $CanvasLayer/PauseMenu
onready var tween = $Tween
export var scaleUpTime:float = 1;
var queueNextAnim = false;
var nextVector = Vector2(1,1)


var is_paused = false
func _on_Pause_pressed():
	changePause()
	$CanvasLayer/ColorRect.visible = true;
	_tpm.popup_centered()
	_tweenObject(Vector2(0,0),Vector2(1.3,1.3));
	

func _tweenObject(from, to):
	tween.interpolate_property($CanvasLayer/PauseMenu, "rect_scale", from, to, scaleUpTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	queueNextAnim =true;
	nextVector = Vector2(1,1)
	tween.start();
	
func _on_Tween_tween_completed(object, key):
	if(queueNextAnim):
		queueNextAnim = false;
		_tweenObject($CanvasLayer/PauseMenu.rect_scale, nextVector);
		tween.start();
		
func _on_Resume_pressed():
	$CanvasLayer/ColorRect.visible = false;
	tween.stop_all();
	if _tpm == null:
		print("_tpm is null")
	else:
		_tpm.hide();
		changePause()
	
func _on_Quit_pressed():
	$"../Transition".transition_in("res://Screens/MainScene.tscn")
	pass # Replace with function body.

func changePause():
	is_paused = !is_paused
	get_tree().paused = is_paused
