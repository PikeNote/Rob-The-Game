extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var websocket_url = "wss://rob-server.pikenote.repl.co/ws"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
var lobbyCode; 

var lobbySelect;
var lobbyScreen;
var gameScreen;
var playerNames;

var player = 1;

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
	_send_data({"type":"createLobby","payload":{"name":UserManager.getFullUsername()}});

func _joinLobby(code):
	_send_data({"type":"joinLobby","payload":{"name":UserManager.getFullUsername(),"match_uuid":str(code)}});

func _letterSpawned(l,i):
	_gameData("letterSpawned",{"letter":l,"path":i});

func _gameData(type, payload):
	_send_data({"user":player,"type":"gameData","payload":{"type":type,"payload":payload,"match_uuid":lobbyCode}});

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	set_process(false)

func _gameStarted():
	_send_data({"type":"lobbyStarted","payload":{"match_uuid":lobbyCode}});

func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	print("Connected to client!")
	_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	

func _on_data():
	var packet:PoolByteArray  = _client.get_peer(1).get_packet()
	var receivedData: Dictionary = JSON.parse(packet.get_string_from_utf8()).result
	
	match(receivedData.type):
		"lobbyCreated":
			lobbyCode = receivedData.payload.game_id; 
			print(lobbyCode)
			lobbyCreated();
			pass;
		"lobbyJoined":
			lobbyJoined(receivedData.payload.name);
			pass;
		"gameData":
			gameData(receivedData.payload)
			pass;
		"lobbyStatus":
			# status = 1 is success
			# status = 0 is fail
			if(receivedData.payload.status == 1):
				playerNames = receivedData.payload.playerNames;
				player = 2;
				lobbyCode = receivedData.payload.match_uuid;
				print(lobbySelect != null)
				if(lobbySelect != null):
					lobbySelect._lobbyCreated();
				pass
			else:
				pass
			pass;
		"lobbyStarted":
			if(lobbyScreen != null):
				lobbyScreen._transition_to_arena();
	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())

func _send_data(data):
	var sendData:String = JSON.print(data)
	_client.get_peer(1).put_packet(sendData.to_utf8())

func _process(delta):
	_client.poll()
	
func lobbyCreated():
	if(lobbySelect!=null):
		lobbySelect._lobbyCreated();

func lobbyJoined(n):
	if(lobbyScreen!=null):
		lobbyScreen._addPlayer(n);
		
func gameData(payload):
	match(payload.type):
		"mouseMoved":
			gameScreen._mouseMoved(Vector2(payload.payload[0],payload.payload[1]))
			pass;
		"mouseClicked":
			gameScreen._dummyShoot(Vector2(payload.payload[0],payload.payload[1]))
			pass;
		"mouseReleased":
			gameScreen._dummyRelease();
			pass;
		"letterSpawned":
			gameScreen._letterSpawned(payload.payload.letter, payload.payload.path)
			pass;
		"powerupUsed":
			pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
