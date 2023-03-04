extends HFlowContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")
	print(maxPageIndex)
	pass # Replace with function body.

var pageIndex = 0;
onready var maxPageIndex = $"../../Pages".get_child_count();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LeftClick_pressed():
	$"../../../ButtonClickSFX".play();
	if(pageIndex - 1 >= 0):
		pageIndex -= 1;
	pageShow();
	
func _on_RightClick_pressed():
	$"../../../ButtonClickSFX".play();
	if(pageIndex + 1 < maxPageIndex):
		pageIndex += 1;
	pageShow();

func pageShow():
	var pageChildren = $"../../Pages".get_children();
	for p in pageChildren:
		p.visible = false;
	
	pageChildren[pageIndex].visible = true;



