extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for m in $".".get_children():
		var modifierBtn:Control = m.get_node("Button");
		var modifier = m.name;
		modifierBtn.connect("pressed", self, '_modifier_button_pressed', [modifierBtn, modifier ] )
	$"../Description".visible = false;
	for s in UserManager.settings.modifiers:
		if(UserManager.settings.modifiers[s]):
			$".".get_node(s).get_node("Button").get_node("Border").visible = true;

func _modifier_button_pressed(modifierBtn, modifier):
	var border:TextureRect = modifierBtn.get_node("Border");
	border.visible = !border.visible;
	UserManager.settings.modifiers[modifier] = border.visible;
	UserManager.updateFile();
	
