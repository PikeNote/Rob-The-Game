extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invAvaliable = [];
var invInUse = [];
var mouse_entered = false;
# Called when the node enters the scene tree for the first time.
func _ready():
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
	for i in invInUse:
		invInUse.remove(i);
	
func _on_mouse_entered() -> void:
	$"../AnimatedGridContainer"._changeOverUI(true);
	
func _on_mouse_leave() -> void:
	$"../AnimatedGridContainer"._changeOverUI(false);

func mouseIn():
	return mouse_entered;


func _input(e):
	if e is InputEventKey and e.pressed:
		if(e.scancode == KEY_BACKSPACE):
			var lastChild:LetterInventory = $AnimatedGridContainer.get_child($AnimatedGridContainer.get_child_count()-1);
			print("ls:"+lastChild.get_letter())
			lastChild._on_Press();
		elif(invAvaliable.has(e.as_text())):
			print("s:"+e.as_text())
			print(e.as_text());
			for n in $AnimatedGridContainer.get_children():
				var letterInv : LetterInventory = n
				if(letterInv.get_letter() == (e.as_text()).to_upper() and !letterInv.already_pressed()):
					n._on_Press();
					break;
		#code
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
