extends Control

func _ready():
	pass
		

func _on_RetryTimer_timeout():
	if(MultiplayerWebsocket._connectToServer()):
		$Transition.transition_in("res://Screens/Multiplayer/LobbySelect.tscn")
	else:
		$Transition.transition_in("res://Screens/MainScene.tscn");


func _on_Transition_transition_out_done():
	if(!MultiplayerWebsocket.socketOpened):
		if(MultiplayerWebsocket._connectToServer()):
			$Transition.transition_in("res://Screens/Multiplayer/LobbySelect.tscn")
		else:
			$RetryTimer.start();
	else:
		$Transition.transition_in("res://Screens/Multiplayer/LobbySelect.tscn")
