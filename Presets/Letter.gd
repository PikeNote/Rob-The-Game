extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _changeLetter(a):
	$LetterKin/Letter.texture = load("res://Assets//Letters//Letter_"+a+".png")

func _physics_process(delta):
	#offset+=speed;
	offset = offset + speed * delta
	rotation = 0;
	if(offset >= 1):
		queue_free();
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
