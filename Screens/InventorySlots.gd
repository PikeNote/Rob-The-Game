extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invAvaliable = [];
var invInUse = [];
var mouse_entered = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GlobalVars.inventoryRef = $"..";
	GlobalVars.pointsEarned = 0;
	GlobalVars.wordsSpelled = [];
	
	pass # Replace with function body.

func _addLetter(l):
	var letter = load("res://Presets/Letter Stuff/LetterInv.tscn").instance()
	$AnimatedGridContainer.add_child(letter);
	letter._changeLetter(l);
	invAvaliable.append(l);

func _invSelect(l):
	invAvaliable.erase(l);
	invInUse.append(l);

func _invDeselect(l):
	invAvaliable.append(l);
	invInUse.erase(l);


func _invCount():
	return invAvaliable.size() + invInUse.size();

func _invRemove():
	invInUse = []
	
func _on_mouse_entered() -> void:
	$"../SpellInventory"._changeOverUI(true);
	
func _on_mouse_leave() -> void:
	$"../SpellInventory"._changeOverUI(false);

func mouseIn():
	return mouse_entered;


func _input(e):
	if e is InputEventKey and e.pressed:
		if(e.scancode == KEY_BACKSPACE):
			if($"../SpellInventory".get_child_count() > 0):
				var invSpellItem = $"../SpellInventory".get_child(0);
				invSpellItem._getLinkedItem()._on_Press();
		elif(invAvaliable.has(e.as_text())):
			for n in $AnimatedGridContainer.get_children():
				var letterInv : LetterInventory = n
				if(letterInv.get_letter() == (e.as_text()).to_upper() and !letterInv.already_pressed()):
					n._on_Press();
					break;
		elif(e.scancode == KEY_ENTER):
			var checkWord = checkWordSolve();
			if(checkWord[0]):
				for invSlot in $"../SpellInventory".get_children():
					invSlot._freeLinked();
					invSlot.queue_free();
				_invRemove();
				GlobalVars.pointsBox._addPoints(checkWord[1]);
				GlobalVars.wordsSpelled.append(checkWord[2]);
				GlobalVars.pointsEarned+=checkWord[1];
				

func checkWordSolve():
	var word = "";
	for invSlot in $"../SpellInventory".get_children():
		word+=invSlot._getLetter();
	word = reverse_string(word.to_lower());
	var wordResult = Words._checkWord(word);
	wordResult.append(word);
	return wordResult;

func reverse_string(s):
	var reversedWord := "" 
	for i in range(s.length()-1, -1, -1):
		reversedWord += s[i]
	return reversedWord
	
		#code
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
