extends HFlowContainer

var pageIndex = 0;
onready var maxPageIndex = $"../../Pages".get_child_count();

func _on_LeftClick_pressed():
	AudioController._playClick();
	if(pageIndex - 1 >= 0):
		pageIndex -= 1;
	pageShow();
	
func _on_RightClick_pressed():
	AudioController._playClick();
	if(pageIndex + 1 < maxPageIndex):
		pageIndex += 1;
	pageShow();

func pageShow():
	var pageChildren = $"../../Pages".get_children();
	for p in pageChildren:
		p.visible = false;
	
	pageChildren[pageIndex].visible = true;



