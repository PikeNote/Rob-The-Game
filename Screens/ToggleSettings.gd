extends HFlowContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fullscreenToggle = false;
var vsyncToggle = false;
var fxaaToggle = false;

onready var toggle = [$Toggle, $"../VSyncSetting/Toggle", $"../FXAASetting/Toggle"]
# Called when the node enters the scene tree for the first time.
func _ready():
	for s in UserManager.settings.graphics:
		match(s):
			"Fullscreen":
				if(UserManager.settings.graphics[s] != fullscreenToggle):
					_on_FullscreenToggle_pressed();
			"VSync":
				if(UserManager.settings.graphics[s] != vsyncToggle):
					_on_VSync_Toggle_pressed();
				pass
			"FXAA":
				if(UserManager.settings.graphics[s] != fxaaToggle):
					_on_FXAA_Toggle_pressed();
				pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Toggle fullscreen selection
func _on_FullscreenToggle_pressed():
	#$"../../../../ButtonClickSFX".play();
	fullscreenToggle = !fullscreenToggle;
	OS.set_window_fullscreen(fullscreenToggle)
	_toggle(fullscreenToggle,0);
	UserManager.settings.graphics.Fullscreen = fullscreenToggle;
	UserManager.updateFile();

func _on_VSync_Toggle_pressed():
	#$"../../../../ButtonClickSFX".play();
	vsyncToggle = !vsyncToggle;
	OS.set_use_vsync(vsyncToggle);
	_toggle(vsyncToggle,1);
	UserManager.settings.graphics.VSync = vsyncToggle;
	UserManager.updateFile();

func _on_FXAA_Toggle_pressed():
	#$"../../../../ButtonClickSFX".play();
	fxaaToggle = !fxaaToggle;
	get_viewport().set_use_fxaa(fxaaToggle)
	_toggle(fxaaToggle,2);
	UserManager.settings.graphics.FXAA = fxaaToggle;
	UserManager.updateFile();


func _toggle(tg,ind):
	if tg:
		toggle[ind].texture_normal=load("res://Assets/MainMenu/Checked-Box.PNG")
	else:
		toggle[ind].texture_normal=load("res://Assets/MainMenu/Unchecked-Box.PNG")

