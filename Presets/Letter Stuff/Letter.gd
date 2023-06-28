extends PathFollow2D


var speed = 200;
var letter;

func change_speed(spd):
	speed = spd;

func get_speed():
	return speed;

func _changeLetter(a):
	$LetterKin/Letter.texture = load("res://Assets//Letters//Letter_"+a+".png")
	letter = a;

func _getLetter():
	return letter;

"""
func _physics_process(delta):
	print(delta)
	#offset+=speed;
	offset = offset + speed * delta
	rotation = 0;
	if(unit_offset >= .99):
		queue_free();
	pass
"""

func _on_OffsetTimer_timeout():
	offset = offset + speed * 0.017;
	rotation = 0;
	if(unit_offset >= .99):
		queue_free();
	pass # Replace with function body.
