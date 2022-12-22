extends PathFollow2D

var speed = 200;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("res://Assets//"+str(round(rand_range(1,3)))+"_Car.png");
	$Sprite.texture = load("res://Assets//"+str(round(rand_range(1,3)))+"_Car.png")
	#$Sprite.texture = load("res://Assets//"+str(rand_range(1,3))+"_Car.png");
	pass # Replace with function body.

func _physics_process(delta):
	#offset+=speed;
	offset = offset + speed * delta
	if(unit_offset >= .99):
		print('free');
		queue_free();
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
