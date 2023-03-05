extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("finished", self, "_on_Finished");
	self.set_process(false);
	self.set_physics_process(false);

func _on_Finished():
	play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
