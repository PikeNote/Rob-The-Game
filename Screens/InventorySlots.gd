extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inv = [];
var mouse_entered = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _addLetter(l):
	var letter = load("res://Presets/Letter Stuff/LetterInv.tscn").instance()
	$AnimatedGridContainer.add_child(letter);
	letter._changeLetter(l);
	inv.append(l);

func _invCount():
	return inv.size();

func _invRemove(word):
	for i in word:
		inv.remove(i);
	
func _on_mouse_entered() -> void:
	$"../AnimatedGridContainer"._changeOverUI(true);
	
func _on_mouse_leave() -> void:
	$"../AnimatedGridContainer"._changeOverUI(false);

func mouseIn():
	return mouse_entered;


#func _input(e):
#	var avaliableLetterObjects = [];
#	var avaliableLetters = [];
#	
#	for n in $AnimatedGridContainer.get_children():
#		if(n.already_pressed()):
#			avaliableLetterObjects.append(n);
#			avaliableLetters.append(n.get_letter());
	
#	if e is InputEventKey:
#		print(event.as_text());
#		if(inv.has(event.as_text())):
			
		#code
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
