extends TextureRect


onready var editNameButton = $EditNameButton;
onready var nameInput = $NameInput;

func _ready():
	nameInput.text = UserManager.settings.username;
	storedName = nameInput.text;
	$NameIdentifier.text = "#" + UserManager.settings.identifier;

var editMode = false;
var storedName = "";

func _on_EditNameButton_pressed():
	editMode = !editMode;
	nameInput.editable = editMode
	if(editMode):
		editNameButton.texture_normal=	load("res://Assets/Settings/ChangeName_Button.PNG");
		if(!nameInput.text.length() > 0):
			nameInput.text = storedName;
		UserManager.settings.username = nameInput.text;
		UserManager.updateFile();
	else:
		editNameButton.texture_normal=	load("res://Assets/Settings/Confirm_Button.PNG");
	
