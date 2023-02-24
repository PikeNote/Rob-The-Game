extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var editMode = false;
var storedName = "";

func _on_TextureButton_pressed():
	editMode = !editMode;
	$VBoxContainer4/VBoxContainer/HBoxContainer/NameInput.editable = !editMode
	if(editMode):
		$VBoxContainer4/VBoxContainer/HBoxContainer/EditNameButton.texture_normal=	load("res://Assets/Edit_Name_Button.png");
		if($VBoxContainer4/VBoxContainer/HBoxContainer/NameInput.text.length() > 0):
			pass
		else:
			$VBoxContainer4/VBoxContainer/HBoxContainer/NameInput.text = storedName;
	else:
		$VBoxContainer4/VBoxContainer/HBoxContainer/EditNameButton.texture_normal=	load("res://Assets/Edit_Check_Button.png");
	pass # Replace with function body.
