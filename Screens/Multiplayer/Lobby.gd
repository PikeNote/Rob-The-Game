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
		_addPlayer(UserManager.username + "#" + UserManager.identifier)
	pass # Replace with function body.

func _addPlayer(name):
	var pLabel = playerLabel.instance();
	$PlayerList.add_child(pLabel);
	pLabel.text = name;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_Button_pressed():
	$Transition.transition_in("res://Screens/Multiplayer/ArenaMap.tscn")
	pass # Replace with function body.
