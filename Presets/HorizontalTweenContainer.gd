extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_child_node(node):
	$Controls.add_child(node)
	var placeholderNode = Control.new();
	placeholderNode.rect_scale=node.rect_scale;
	placeholderNode.visible = false;
	
	$PlaceholderContainer.add_child(placeholderNode);
	updateNodes();
	
func updateNodes():
	for i in $Controls.get_child_count():
		var n = $Controls.get_child(i);
		var tween = Tween.new();
		tween.interpolate_property(n, "rect_position:x", n.rect_position.x, placeholderNode.get_child(i).rect_position.x, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		add_child(tween)
		tween.start()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
