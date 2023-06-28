extends Node2D


var playerLabel = load("res://Presets/Multiplayer/PlayerLabel.tscn")

func _ready():
	$LobbyCode.text = MultiplayerWebsocket.lobbyCode;
	MultiplayerWebsocket.lobbyScreen = $".";
	if(MultiplayerWebsocket.playerNames==null):
		_addPlayer(UserManager.getFullUsername())
	else:
		for n in MultiplayerWebsocket.playerNames:
			_addPlayer(n);
	
	if(MultiplayerWebsocket.player == 0):
		$StartGame.visible = true;
	pass # Replace with function body.

func _addPlayer(name):
	var pLabel = playerLabel.instance();
	$PlayerList.add_child(pLabel);
	pLabel.text = name;


func _on_Start_Button_pressed():
	MultiplayerWebsocket._gameStarted();
	$Transition.transition_in("res://Screens/Multiplayer/ArenaMap.tscn")

func _transition_to_arena():
	$Transition.transition_in("res://Screens/Multiplayer/ArenaMap.tscn");

func _on_LobbyCode_pressed():
	OS.set_clipboard(MultiplayerWebsocket.lobbyCode);

func _on_ExitButton_pressed():
	MultiplayerWebsocket._leaveLobby();
	$Transition.transition_in("res://Screens/Multiplayer/LobbySelect.tscn");
