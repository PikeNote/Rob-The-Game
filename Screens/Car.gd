extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout",self,"_spawnCar")
	$".".start();
	pass # Replace with function body.

func _spawnCar():
	var c = load("res://Presets/Car.tscn").instance()
	$"../Node2D/Car1".add_child(c);
	
	var t = Timer.new()
	t.set_wait_time(rand_range(1,3))
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free();
	
	var c1 = load("res://Presets/Car.tscn").instance()
	$"../Node2D/Car2".add_child(c1);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
