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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Toggle fullscreen selection
func _on_FullscreenToggle_pressed():
	print('test')
	fullscreenToggle = !fullscreenToggle;
	OS.set_window_fullscreen(fullscreenToggle)
	_toggle(fullscreenToggle,0);
	print("toggled")

func _on_VSync_Toggle_pressed():
	vsyncToggle = !vsyncToggle;
	OS.set_use_vsync(vsyncToggle);
	_toggle(vsyncToggle,1);

func _on_FXAA_Toggle_pressed():
	fxaaToggle = !fxaaToggle;
	get_viewport().set_use_fxaa(fxaaToggle)
	_toggle(fxaaToggle,2);


func _toggle(tg,ind):
	if tg:
		toggle[ind].texture_normal=load("res://Assets/MainMenu/Checked-Box.PNG")
	else:
		toggle[ind].texture_normal=load("res://Assets/MainMenu/Unchecked-Box.PNG")

