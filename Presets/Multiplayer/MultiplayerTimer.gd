extends Timer

export var pathSpawn = "./Path2D";
export var modulate = "FFFFFF";
export var timer_ind = 0;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout",self,"_spawn_letter")
	$".".start();
	pass # Replace with function body.

func generateRandomLetter():
	var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1, 10)
	
	match(num):
		1,2,3,4:
			letters="AEIOU"
		5,6,7:
			letters="LNSTRDGBCMPFHVWY"
		8,9:
			letters="KJX"
		_:
			letters="QZ"
	return letters[randi()% len(letters)];

func _spawn_letter():
	var letterList = [];
	for i in range(2):
		letterList.append(generateRandomLetter());
	print("Sent")
	MultiplayerWebsocket._letterSpawned(letterList);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

