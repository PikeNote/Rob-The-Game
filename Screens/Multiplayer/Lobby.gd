extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var playerLabel = load("res://Presets/Multiplayer/PlayerLabel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$LobbyCode.text = MultiplayerWebsocket.lobbyCode;
	MultiplayerWebsocket.lobbyScreen = $".";
	if(MultiplayerWebsocket.playerNames==null):
		_addPlayer(UserManager.getFullUsername())
	else:
		for n in MultiplayerWebsocket.playerNames:
			_addPlayer(n);
	pass # Replace with function body.

func _addPlayer(name):
	var pLabel = playerLabel.instance();
	$PlayerList.add_child(pLabel);
	pLabel.text = name;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_Button_pressed():
	MultiplayerWebsocket._gameStarted();
	$Transition.transition_in("res://Screens/Multiplayer/ArenaMap.tscn")
	pass # Replace with function body.

func _transition_to_arena():
	$Transition.transition_in("res://Screens/Multiplayer/ArenaMap.tscn");

func _on_LobbyCode_pressed():
	OS.set_clipboard(MultiplayerWebsocket.lobbyCode);
	pass # Replace with function body.
