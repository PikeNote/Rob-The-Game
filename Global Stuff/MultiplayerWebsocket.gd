extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var websocket_url = "wss://rob-server.pikenote.repl.co/ws"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
var lobbyCode; 

var lobbyScreen;

# Called when the node enters the scene tree for the first time.
func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")

	var err = _client.connect_to_url(websocket_url)
	print(err);
	if err != OK:
		print("Unable to connect")
		set_process(false)


func _createLobby():
	_send_data({"type":"createLobby"});
	

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	print("Connected to client!")
	

func _on_data():
	var packet = _client.get_peer(1).get_packet()
	var receivedData: Dictionary = JSON.parse(packet.get_string_as_utf8()).result
	
	match(receivedData.type):
		"lobbyCreated":
			lobbyCode = receivedData.payload.game_id; 
			
			pass;
		"lobbyFailed":
			pass;
		"mouseMoved":
			pass;
		"mouseClicked":
			pass;
		"powerupUsed":
			pass;
		"spellAdd":
			pass;
		"spellRemove":
			pass;
	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())

func _send_data(data):
	var sendData:String = JSON.print(data)
	_client.get_peer(1).put_packet(sendData.to_utf8())

func _process(delta):
	_client.poll()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
