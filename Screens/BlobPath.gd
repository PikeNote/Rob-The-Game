extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var numCountBlobs = 0;
var count = 0;
var blobObj = load("res://Presets/TheBlob.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(numCountBlobs):
		var blob = blobObj.instance()
		self.add_child(blob);
		blob.unit_offset += count * 0.0336;
		count+=1;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

