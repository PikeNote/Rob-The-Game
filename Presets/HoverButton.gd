extends TextureButton

func _ready():
	connect("mouse_entered", self, "_on_Mouse_Enter")
	connect("mouse_exited", self, "_on_Mouse_Leave")
	connect("pressed", self, "_on_Mouse_Pressed")
	pass # Replace with function body.

func _on_Mouse_Enter():
	modulate = Color("e5e5e5")

func _on_Mouse_Leave():
	modulate = Color("ffffff")

func _on_Mouse_Pressed():
	AudioController._playClick();
