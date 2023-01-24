extends Button

onready var _tpm = $"../../PauseMenuNode/PauseMenu"

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused

func _on_Pause_pressed():
	print("The pause button is being pressed.")
	
	self.is_paused = !is_paused
	_tpm.popup()

func _on_Resume_pressed():
	print("The resume button is being pressed.")
	if _tpm == null:
		print("_tpm is null")
	self.is_paused = false
