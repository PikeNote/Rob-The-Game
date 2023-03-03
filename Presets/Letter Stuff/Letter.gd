extends PathFollow2D


var speed = 200;
var letter;

func change_speed(spd):
	speed = spd;

func _changeLetter(a):
	$LetterKin/Letter.texture = load("res://Assets//Letters//Letter_"+a+".png")
	letter = a;

func _getLetter():
	return letter;

func _physics_process(delta):
	#offset+=speed;
	offset = offset + speed * delta
	rotation = 0;
	if(unit_offset >= .99):
		queue_free();
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
