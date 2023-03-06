extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var transition = $Transition;

# Called when the node enters the scene tree for the first time.
func _ready():
	MultiplayerWebsocket.lobbySelect = $".";
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CreateLobby_pressed():
	MultiplayerWebsocket._createLobby();
	
func _lobbyCreated():
	transition.transition_in("res://Screens/Multiplayer/Lobby.tscn");

func _on_JoinLobby_pressed():
	MultiplayerWebsocket._joinLobby($VBoxContainer/LobbyCode/TextEdit.text)
