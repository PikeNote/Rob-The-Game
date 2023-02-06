extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pressed_before = false;
var currentLetter;

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
		$"../../../AnimatedGridContainer".add_child(currentLetter);
		$"../../../AnimatedGridContainer".move_child(currentLetter, 0);
		
		currentLetter._changeLetter($"Label".text)
		currentLetter._setLink($".");
		
		var word = "";
		for invSlot in $"../../../AnimatedGridContainer".get_children():
			word+=invSlot._getLetter();
		word = reverse_string(word.to_lower());
		var checkWd = Words._checkWord(word);

		if(checkWd[0]):
			GarbageCollector._clearSpell($"../../../AnimatedGridContainer");
			$"../../../InventorySlots"._invRemove(word);
			$"../../../Points"._addPoints(checkWd[1]);
			pass;
	else:
		currentLetter.queue_free();
		currentLetter = null;
		$"Label".add_color_override("font_color", Color(1,1,1,1));
		pressed_before = false;
	pass;
	
func reverse_string(s):
	var reversedWord := "" 
	for i in range(s.length()-1, -1, -1):
		reversedWord += s[i]
	return reversedWord

func already_pressed():
	return pressed_before;

func get_letter():
	return $"Label".text;
