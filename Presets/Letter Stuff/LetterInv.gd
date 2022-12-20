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
		currentLetter._changeLetter($"Label".text)
		currentLetter._setLink($".");
		
		var word = "";
		for invSlot in $"../../../AnimatedGridContainer".get_children():
			word+=invSlot._getLetter();
		word = word.to_lower();
		
		if(Words._checkWord(word)):
			# add points or smth
			GarbageCollector._clearSpell($"../../../AnimatedGridContainer");
			pass;
	else:
		currentLetter.queue_free();
		currentLetter = null;
		$"Label".add_color_override("font_color", Color(1,1,1,1));
		pressed_before = false;
	pass;
