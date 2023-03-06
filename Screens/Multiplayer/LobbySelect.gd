extends Node2D

onready var transition = $Transition;

func _ready():
	MultiplayerWebsocket.lobbySelect = $".";

func _on_CreateLobby_pressed():
	MultiplayerWebsocket._createLobby();
	
func _lobbyCreated():
	transition.transition_in("res://Screens/Multiplayer/Lobby.tscn");

func _on_JoinLobby_pressed():
	MultiplayerWebsocket._joinLobby($VBoxContainer/LobbyCode/TextEdit.text)
