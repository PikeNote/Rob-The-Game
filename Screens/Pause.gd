extends Node2D

onready var _tpm = $CanvasLayer/PauseMenu

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused

func _on_Pause_pressed():
	self.is_paused = !is_paused
	_tpm.popup_centered()

func _on_Resume_pressed():
	if _tpm == null:
		print("_tpm is null")
	else:
		_tpm.hide();
		self.is_paused = false
	
func _on_Quit_pressed():
	get_tree().change_scene("res://Screens/MainScene.tscn")
	pass # Replace with function body.
