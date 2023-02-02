extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var index = 1;

var contactOnce= false;

var planet;
# Called when the node enters the scene tree for the first time.


func _ready():
	planet = $"../../Planet";
	self.connect("body_entered", self, "_on_Area2D_body_entered")
	pass # Replace with function body.
	
func _on_Area2D_body_entered(body):
	if(body.name != "Planet2" && planet._getCurrentPlace() != index):
		if(!contactOnce):
			contactOnce = true;
			planet._pauseLoop();
		else:
			contactOnce = false;
			planet._doneMoving(index);
