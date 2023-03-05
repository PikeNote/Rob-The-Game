extends Sprite

var overUI = false;


func _changeOverUI(b):
	overUI = b;

func _physics_process(delta):
	if(not $Lasso.visible):
		$".".look_at(get_viewport().get_mouse_position())
		$".".rotation_degrees -= 90
	
func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton && GameReferences.inventoryRef.get_node("InventorySlots")._invCount()<20 && !overUI):
		if event.pressed:
			if(MultiplayerWebsocket.lobbyCode):
				print("mouseClicked")
				MultiplayerWebsocket._gameData("mouseClicked",[event.position.x,event.position.y]);
			$Lasso.shoot(event.position)
		else:
			if(MultiplayerWebsocket.lobbyCode):
				MultiplayerWebsocket._gameData("mouseReleased",[event.position.x,event.position.y])
			$Lasso.release()
