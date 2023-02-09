extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "_on_Mouse_Enter")
	connect("mouse_exited", self, "_on_Mouse_Leave")
	pass # Replace with function body.

func _on_Mouse_Enter():
	modulate = Color("e5e5e5")

func _on_Mouse_Leave():
	modulate = Color("ffffff")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
