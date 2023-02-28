extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var transition = self.owner.get_node("Transition")

func _on_ExitButton_pressed():
	transition.transition_in("res://Screens/MainScene.tscn");
