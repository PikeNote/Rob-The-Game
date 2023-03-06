extends Node

export var websocket_url = "wss://rob-server.pikenote.repl.co/ws"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
var lobbyCode; 

var lobbySelect;
var lobbyScreen;
var gameScreen;
var playerNames;

var player = 1;

var socketOpened = false;

func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")

# Attempt to connect to the server and retry the same conneciton if unsuccessful
func _connectToServer():
	var err = _client.connect_to_url(websocket_url)
	print(err);
	return err;
	if err != OK:
		print("Unable to connect")
		set_process(false)
		return false
	else:
		socketOpened = true;
		set_process(true)
		return true

# Example received data template
"""
{
	
}
"""

func _on_data():
	var packet:PoolByteArray  = _client.get_peer(1).get_packet()
	var receivedData: Dictionary = JSON.parse(packet.get_string_from_utf8()).result
	match(receivedData.type):
		"lobbyCreated":
			lobbyCode = receivedData.payload.game_id; 
			lobbyCreated();
		"lobbyJoined":
			lobbyJoined(receivedData.payload.name);
		"gameData":
			gameData(receivedData.payload)
			pass;
		"lobbyStatus":
			lobbyJoin(receivedData.payload)
		"gameEnded":
			pass;
		"lobbyStarted":
			if(lobbyScreen != null):
				lobbyScreen._transition_to_arena();

# On connection to the server
func _connected(proto = ""):
	print("Connected websocket to server!")
	_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)

# Send JSON data packets to the server
func _send_data(data):
	var sendData:String = JSON.print(data)
	_client.get_peer(1).put_packet(sendData.to_utf8())
	
# Functions related to joining/creating a lobby and calling the proper functions
func lobbyCreated():
	if(lobbySelect!=null):
		lobbySelect._lobbyCreated();

func lobbyJoined(n):
	if(lobbyScreen!=null):
		lobbyScreen._addPlayer(n);

func lobbyJoin(payload):
	# status = 1 is success
	# status = 0 is fail
	if(payload.status == 1):
		playerNames = payload.playerNames;
		player = 2;
		lobbyCode = payload.match_uuid;
		if(lobbySelect != null):
			lobbySelect._lobbyCreated();
		pass


func _closed(was_clean = false):
	socketOpened = false;
	lobbyCode = "";
	print("Closed, clean: ", was_clean)
	set_process(false)


#  Functions to send packets to the server regarding lobby creation, joining lobbies, and game related data
func _createLobby():
	_send_data({"type":"createLobby","payload":{"name":UserManager.getFullUsername()}});

func _joinLobby(code):
	_send_data({"type":"joinLobby","payload":{"name":UserManager.getFullUsername(),"match_uuid":str(code)}});

# Packet regarding any data within in the game
func _gameData(type, payload):
	_send_data({"user":player,"type":"gameData","payload":{"type":type,"payload":payload,"match_uuid":lobbyCode}});

# Send packets regarding newly spawned letters
func _letterSpawned(l,i):
	_gameData("letterSpawned",{"letter":l,"path":i});

# Packets to start the game
func _gameStarted():
	_send_data({"type":"lobbyStarted","payload":{"match_uuid":lobbyCode}});

# Switch case statement to process the game data according
# This includes: mouse movement data, mouse clicking data, mouse release date, letter spawning data
func gameData(payload):
	match(payload.type):
		"mouseMoved":
			gameScreen._mouseMoved(Vector2(payload.payload[0],payload.payload[1]))
		"mouseClicked":
			gameScreen._dummyShoot(Vector2(payload.payload[0],payload.payload[1]))
		"mouseReleased":
			gameScreen._dummyRelease();
		"letterSpawned":
			gameScreen._letterSpawned(payload.payload.letter, payload.payload.path)


# Poll for updates from the server
func _process(delta):
	_client.poll()
