extends VBoxContainer


onready var editNameButton = $DisplayContainer/EditNameButton;
onready var nameInput = $DisplayContainer/NameInput;

func _ready():
	nameInput.text = UserManager.username;
	$DisplayContainer/NameIdentifier.text = "#" + UserManager.identifier;

var editMode = false;
var storedName = "";

func _on_EditNameButton_pressed():
	editMode = !editMode;
	nameInput.editable = !editMode
	if(editMode):
		editNameButton.texture_normal=	load("res://Assets/Edit_Name_Button.png");
		if(nameInput.text.length() > 0):
			
			pass
		else:
			nameInput.text = storedName;
	else:
		editNameButton.texture_normal=	load("res://Assets/Edit_Check_Button.png");
	
