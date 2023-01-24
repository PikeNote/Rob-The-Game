extends Timer

export var pathSpawn = "./Path2D";
export var modulate = "FFFFFF";
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout",self,"_spawn_letter")
	$".".start();
	pass # Replace with function body.


func _spawn_letter():
	var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1, 10)
	
	match(num):
		1,2,3,4:
			letters="AEIOULNSTRDG"
		5,6,7:
			letters="BCMPFHVWY"
		8,9:
			letters="KJX"
		_:
			letters="QZ"
	
	var letter = load("res://Presets/Letter Stuff/Letters.tscn").instance()
	get_node(pathSpawn).add_child(letter);
	letter._changeLetter(letters[randi()% len(letters)]);
	letter.modulate=Color(modulate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

