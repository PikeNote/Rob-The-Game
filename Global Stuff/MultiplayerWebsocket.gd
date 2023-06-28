extends Node

export var websocket_url = "wss://rob-server.pikenote.repl.co/ws"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
var lobbyCode; 

var lobbySelect;
var lobbyScreen;
var gameScreen;
var playerNames;

var player = 0;

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
	if err != OK:
		print("Unable to connect")
		set_process(false)
		return false
	else:
		socketOpened = true;
		set_process(true)
		return true

# On connection to the server
func _connected(proto = ""):
	print("Connected websocket to server!")
	_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)

# Send JSON data packets to the server
func _send_data(data):
	if(socketOpened):
		var sendData:String = JSON.print(data)
		_client.get_peer(1).put_packet(sendData.to_utf8())
# Example received data template


func _on_data():
	var packet:PoolByteArray  = _client.get_peer(1).get_packet()
	var receivedData: Dictionary = JSON.parse(packet.get_string_from_utf8()).result
	print(receivedData.type)
	match(receivedData.type):
		"lobbyCreated":
			# Lobby creation successful with a returned lobby code
			lobbyCode = receivedData.payload.game_id; 
			lobbyCreated();
			"""
			{
				"type":"lobbyCreated",
				"payload": {
					"game_id":"0123516"
				}
			}
			"""
		"lobbyJoined":
			# User joined a lobby; emitted to all other players in the lobby
			"""
			{
				"type":"lobbyJoined",
				"payload": {
					"name":"nameOfUserJoining"
				}
			}
			"""
			lobbyJoined(receivedData.payload.name);
		"gameData":
			# Game data reuqests vary on what is being receive/tpeo of reuqest
			# Refer to switch statemnt below for more clarification
			"""
			{
				"type":"gameData",
				"payload": {
					"type":"mouseMoved",
					"payload": [124,124]
				}
			}
			"""
			gameData(receivedData.payload)
			
		"lobbyStatus":
			# Lobby sucessfully joined; sends back a list of players to be processed and the match ID
			"""
			{
				"type":"lobbyStatus",
				"payload":{
					"status":1,
					"playerNames":['Player1#2012','Player2#1222'],
					"match_uuid":"416123"
				}
			}
			"""
			lobbyJoin(receivedData.payload)
		"gameEnded":
			# Game has ended- server has received both scores
			"""
			{
				"type":"gameEnded",
				"payload":{
					"scores":[100,200],
					"winner":1
				}
			}
			"""
			gameEnded(receivedData.payload);
		"lobbyStarted":
			# Simple request to start the game on both clients
			#{"type":"lobbyStarted"}
			lobbyStarted();
		"startSpawn":
			# Start spawning of letters
			gameScreen._startSpawn();


	
# Functions related to joining/creating a lobby and calling the proper functions
# Transiiton to the lobby screen; pass and execute functions on external scenes
func lobbyCreated():
	if(lobbySelect!=null):
		lobbySelect._lobbyCreated();

# Add player label based on the data redeived onto the lobby screen
# Check references of the lobby selection screen being properly referenced
func lobbyJoined(n):
	if(lobbyScreen!=null):
		lobbyScreen._addPlayer(n);

func lobbyJoin(payload):
	# status = 1 is success
	# status = 0 is fail
	if(payload.status == 1):
		playerNames = payload.playerNames;
		player = 1;
		lobbyCode = payload.match_uuid;
		if(lobbySelect != null):
			lobbySelect._lobbyCreated();
		pass

func lobbyStarted():
	if(lobbyScreen != null):
		lobbyScreen._transition_to_arena();


# Fnuctions relating to ending the game
func gameEnded(payload):
	gameScreen._endGame(payload)
	pass;

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
func _letterSpawned(l):
	_gameData("letterSpawned",{"letter":l,"unix":OS.get_unix_time()});
	gameScreen._letterSpawned(l,OS.get_unix_time());

# Packets to notify that a specific letter is grabbed
func letterGrabbed(id):
	_gameData("letterGrabbed", {"letter":id})

# Packets to start the game
func _gameStarted():
	_send_data({"type":"lobbyStarted","payload":{"match_uuid":lobbyCode}});
	
# Packets to leave the lobby
func _leaveLobby():
	_send_data({"type":"lobbyLeave","payload":{"match_uuid":lobbyCode}});

func _endGame(p):	
	_send_data({"type":"gameEnded","user":player,"payload":{"points":p,"match_uuid":lobbyCode}});

func _gameReady():
	print("Game ready sent!")
	_send_data({"type":"readyGame"});

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
			gameScreen._letterSpawned(payload.payload.letter, payload.payload.unix)
		"letterGrabbed":
			var lt = gameScreen.removeLetter(payload.payload.letter);
			gameScreen._dummyChange(lt);




# Poll for updates from the server
func _process(delta):
	_client.poll()
