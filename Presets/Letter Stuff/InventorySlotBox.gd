extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var linkedInvItem;
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _changeLetter(l):
	$"Label".text=l;

func _getLetter():
	return $"Label".text;

func _setLink(a):
	linkedInvItem = a;

func _getLinkedItem():
	return linkedInvItem;

func _freeLinked():
	linkedInvItem.queue_free();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
