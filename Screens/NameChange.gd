extends VBoxContainer


onready var editNameButton = $DisplayContainer/EditNameButton;
onready var nameInput = $DisplayContainer/NameInput;

func _ready():
	nameInput.text = UserManager.username;
	storedName = nameInput.text;
	$DisplayContainer/NameIdentifier.text = "#" + UserManager.identifier;

var editMode = false;
var storedName = "";

func _on_EditNameButton_pressed():
	editMode = !editMode;
	nameInput.editable = !editMode
	if(editMode):
		editNameButton.texture_normal=	load("res://Assets/Settings/ChangeName_Button.PNG");
		if(!nameInput.text.length() > 0):
			nameInput.text = storedName;
	else:
		editNameButton.texture_normal=	load("res://Assets/Settings/Confirm_Button.PNG");
	
