extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var robPosition = [Vector2(428,479),Vector2(964,479)];
var dummy;
onready var tracks = [$TopPath, $BottomPath]
var letter = load("res://Presets/Letter Stuff/Letters.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	MultiplayerWebsocket.gameScreen = $"."
	
	var plr = load("res://Presets/Rob.tscn").instance();
	dummy = load("res://Presets/DummyPlayer.tscn").instance();
	add_child(plr)
	add_child(dummy)
	plr.scale = Vector2(1.25,1.25);
	dummy.scale = Vector2(1.25,1.25);
	if(MultiplayerWebsocket.player == 1):
		plr.position = robPosition[0];
		dummy.position = robPosition[1];
		plr.get_node("Rob").texture = load("res://Assets/rob.png");
		dummy.get_node("Rob").texture = load("res://Assets/Multiplayer/Lady_Robin_The_Ram.png");
	else:
		# Remove both timers as player 2's spawns are dictated by player 1
		$SpawnTimer.queue_free();
		$SpawnTimer2.queue_free();
		
		plr.position = robPosition[1];
		dummy.position = robPosition[0];
		plr.get_node("Rob").texture = load("res://Assets/Multiplayer/Lady_Robin_The_Ram.png");
		dummy.get_node("Rob").texture = load("res://Assets/rob.png");
	dummy = dummy.get_node("Rob");
	
	pass # Replace with function body.

func _mouseMoved(pos:Vector2):
	$Player2MousePos.position = pos;
	
func _dummyShoot(pos:Vector2):
	dummy._shoot(pos);

func _dummyRelease():
	dummy._release();

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		MultiplayerWebsocket._gameData("mouseMoved",[event.position.x,event.position.y])

func _letterSpawned(letter_string,track_ind):
	print(track_ind)
	var lt = letter.instance();
	tracks[track_ind].add_child(lt);
	lt._changeLetter(letter_string);
	lt.modulate=Color(modulate)

