extends Button

onready var _spm = $"../../SettingsPopupMenu"

func _on_Button_pressed():
	_spm.popup()
	
