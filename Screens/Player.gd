extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var overUI = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	

func _changeOverUI(b):
	overUI = b;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if(not $Chain.visible):
		$".".look_at(get_viewport().get_mouse_position())
		$".".rotation_degrees -= 90
	
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton && GlobalVars.inventoryRef.get_node("InventorySlots")._invCount()<20 && !overUI):
		if event.pressed:
			if(MultiplayerWebsocket.lobbyCode):
				print("mouseClicked")
				MultiplayerWebsocket._gameData("mouseClicked",[event.position.x,event.position.y]);
			$Chain.shoot(event.position)
		else:
			if(MultiplayerWebsocket.lobbyCode):
				MultiplayerWebsocket._gameData("mouseReleased",[event.position.x,event.position.y])
			$Chain.release()
