extends Timer

export var pathSpawn = "./Path2D";
export var modulate = "FFFFFF";

var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var rng = RandomNumberGenerator.new()

var letterSpawns = ["AEIOU","LNSTRDGBCMPFHVWY","KJX","QZ"];

var letterRates;

var offset_speed;

func _ready():
	connect("timeout",self,"_spawn_letter")
	$".".start();
	print("Vowel grabbed")
	var GameManager = $".".owner.get_node("GameManager");
	letterRates = GameManager.get("letterRates");
	letterSpawns = GameManager.get("letterSpawns");
	offset_speed = GameManager.get("offsetSpeed");

func _spawn_letter():
	rng.randomize()
	var num = rng.randi_range(1, 10)
	
	letters = letterSpawns[letterRates[num-1]]
	
	var letter = load("res://Presets/Letter Stuff/Letters.tscn").instance()
	get_node(pathSpawn).add_child(letter);
	letter._changeLetter(letters[randi()% len(letters)]);
	letter.change_speed(offset_speed);
	letter.modulate=Color(modulate)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

