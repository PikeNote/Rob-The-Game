extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var index = 1;

var planet;
# Called when the node enters the scene tree for the first time.
func _ready():
	planet = $"../../Planet";
	self.connect("body_entered", self, "_on_Area2D_body_entered")
	pass # Replace with function body.
	
func _on_Area2D_body_entered(body):
	print(body)
	if(planet._getCurrentPlace() != index && body.name == "KinematicBody2D"):
		planet._doneMoving(index);
