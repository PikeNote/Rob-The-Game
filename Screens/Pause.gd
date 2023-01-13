extends Button

onready var _tpm = $"../../PauseMenu"

func _on_Pause_pressed():
	_tpm.popup()
