extends Button

class_name LetterInventory

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pressed_before = false;
var currentLetter;
onready var inventoryContainer = GlobalVars.inventoryRef.get_node("SpellInventory");
onready var inventorySlots = GlobalVars.inventoryRef.get_node("InventorySlots");
onready var pointsBox = GlobalVars.pointsBox;
# Called when the node enters the scene tree for the first time.
func _ready():
	$".".connect("pressed", self, "_on_Press")
	pass # Replace with function body.

func _changeLetter(a):
	$"Label".text = a;
func _on_Press():
	if(!pressed_before):
		$"Label".add_color_override("font_color", Color(0,1.0,0,1));
		pressed_before = true;
		currentLetter = load("res://Presets/Letter Stuff/LetterSpell.tscn").instance()
		inventoryContainer.add_child(currentLetter);
		inventoryContainer.move_child(currentLetter, 0);
		
		currentLetter._changeLetter($"Label".text)
		currentLetter._setLink($".");
	else:
		currentLetter.queue_free();
		inventoryContainer.remove_child(currentLetter);
		currentLetter = null;
		$"Label".add_color_override("font_color", Color(1,1,1,1));
		pressed_before = false;
	pass;

func already_pressed():
	return pressed_before;

func get_letter():
	return $"Label".text;
