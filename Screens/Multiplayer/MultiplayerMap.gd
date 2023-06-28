extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var robPosition = [Vector2(428,479),Vector2(964,479)];
var dummy;
onready var tracks = [$TopPath, $BottomPath]
var letter = ResourceLoader.load("res://Presets/Letter Stuff/Letters.tscn")
var letterCounter = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.stop();
	MultiplayerWebsocket.gameScreen = $"."
	
	var plr = ResourceLoader.load("res://Presets/Rob.tscn").instance();
	dummy = ResourceLoader.load("res://Presets/DummyPlayer.tscn").instance();
	add_child(plr)
	add_child(dummy)
	plr.scale = Vector2(1.25,1.25);
	dummy.scale = Vector2(1.25,1.25);
	print("Multiplayer player: " + str(MultiplayerWebsocket.player));
	if(MultiplayerWebsocket.player == 0):
		plr.position = robPosition[0];
		dummy.position = robPosition[1];
		plr.get_node("Rob").texture = ResourceLoader.load("res://Assets/RobMain.png");
		dummy.get_node("Rob").texture = ResourceLoader.load("res://Assets/Multiplayer/Lady_Robin_The_Ram.png");
	else:
		# Remove both timers as player 2's spawns are dictated by player 1
		$SpawnTimer.queue_free();
		
		plr.position = robPosition[1];
		dummy.position = robPosition[0];
		plr.get_node("Rob").texture = ResourceLoader.load("res://Assets/Multiplayer/Lady_Robin_The_Ram.png");
		dummy.get_node("Rob").texture = ResourceLoader.load("res://Assets/RobMain.png");
	dummy = dummy.get_node("Rob");
	
	pass # Replace with function body.

func _mouseMoved(pos:Vector2):
	$Player2MousePos.position = pos;
	
func _dummyShoot(pos:Vector2):
	dummy._shoot(pos);

func _dummyRelease():
	dummy._release();

func _dummyChange(s):
	dummy.emulateLasso(s);

func _startSpawn():
	$SpawnTimer.start();

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if($MouseTimer.time_left==0):
			$MouseTimer.start();

func _letterSpawned(letterList:Array, unix):
	for i in range(letterList.size()):
		letterCounter+=1;
		var lt: PathFollow2D = letter.instance();
		tracks[i].add_child(lt);
		lt._changeLetter(letterList[i]);
		lt.modulate=Color(modulate)
		lt.setCounter(letterCounter);
		
		var timeUpdateBetween = (OS.get_unix_time() - unix)/0.017;
		print(timeUpdateBetween);
		lt.offset = timeUpdateBetween * (0.017*lt.get_speed());

func removeLetter(c):
	for letter in ($TopPath.get_children() + $BottomPath.get_children()):
		if(letter.getCounter() == c):
			var letter_text = letter._getLetter();
			letter.queue_free();
			return letter_text;

func _endGame(p):
	$SpawnTimer.queue_free();
	$EndGameScreen.multiplayerReults(p);

func _on_MouseTimer_timeout():
	var globalMousePosition = get_global_mouse_position();
	MultiplayerWebsocket._gameData("mouseMoved",[globalMousePosition.x,globalMousePosition.y])
	pass # Replace with function body.


func _on_Transition_transition_out_done():
	MultiplayerWebsocket._gameReady();
	pass # Replace with function body.
