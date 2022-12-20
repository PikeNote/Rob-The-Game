extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _clearSpell(a):
	for invSlot in a.get_children():
		invSlot._freeLinked();
		invSlot.queue_free();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
