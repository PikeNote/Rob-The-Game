extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var transition = $Transition;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CreateLobby_pressed():
	MultiplayerWebsocket._createLobby();
	MultiplayerWebsocket.lobbyMap = ".";
	
func _lobbyCreated():
	transiton.transition_in("res://Screens/Multiplayer/Lobby.tscn");
	
