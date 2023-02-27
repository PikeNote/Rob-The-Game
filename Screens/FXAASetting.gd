extends HFlowContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var toggle = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Toggle fullscreen selection
func _on_FullscreenToggle_button_down():
	toggle = !toggle;
	get_viewport().set_use_fxaa(toggle)
	if toggle:
		$FXAAToggle.texture_normal=load("res://Assets/MainMenu/check.png")
	else:
		$FXAAToggle.texture_normal=load("res://Assets/MainMenu/unchecked.png")
