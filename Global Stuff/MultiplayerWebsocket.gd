extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var websocket_url = "wss://rob-webrtc.pikenote.repl.co/ws"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
var lobbyCode; 

var lobbySelect;
var lobbyScreen;
var gameScreen;
var playerNames;

var host = false;

var rtc_peer:WebRTCMultiplayer = WebRTCMultiplayer.new();

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
		
func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	print("Connected to client!")
	_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	

func _on_data():
	var packet:PoolByteArray  = _client.get_peer(1).get_packet()
	var receivedData: Dictionary = JSON.parse(packet.get_string_from_utf8()).result
	print(receivedData)
	match(receivedData.type):
		"lobbyCreated":
			lobbyCode = receivedData.code; 
			lobbyCreated();
			host = true;
			pass;
		"lobbyJoined":
			lobbyJoined(receivedData);
			pass;
		"canidate":
			_candidate_received(receivedData.id,receivedData.canidate[0],receivedData.canidate[1],receivedData.canidate[2])
			pass;
		"answer":
			_answer_received(receivedData.id,receivedData.answer)
		"joinSucessful":
			pass;
func lobbyCreated():
	pass;

func lobbyJoined(data):
	print("Intializing WebRTC connection/peer for %s" % data.user )
	var peer:WebRTCPeerConnection = WebRTCPeerConnection.new();
	peer.initialize({
		"iceServers": [{"urls":["stun:stun.l.google.com:19302"]}]
	})
	
	peer.connect("session_description_created",self,"_offer_created",[2])
	peer.connect("ice_candidate_created",self, "_new_ice_candidate", [2])
	rtc_peer.add_peer(peer, 2)
	peer.create_offer()
	
	pass

func _send_data(data):
	var sendData:String = JSON.print(data)
	_client.get_peer(1).put_packet(sendData.to_utf8())

func _offer_created( type, data, id):
	if not rtc_peer.has_peer(id):
		return
	print("created", type)
	rtc_peer.get_peer(id).connection.set_local_description(type, data)
	if type == "offer": send_offer(id, data)
	else: send_answer(id, data)

func send_offer(id, data):
	_send_data({
		"type":"offer",
		"offer":data,
		"id":id,
		"user":UserManager.getFullUsername(),
		"code":lobbyCode
	})

func _new_ice_candidate(mid_name, index_name, sdp_name, id):
	var sendTo = 0;
	if(host):
		sendTo = 1;
	
	_send_data({
		"type":"canidate",
		"canidate":[mid_name,index_name,sdp_name],
		"sendTo":sendTo,
		"id":id,
		"user":UserManager.getFullUsername(),
		"code":lobbyCode
	})
	
func send_answer(id, data):
	_send_data({
		"type":"answer",
		"answer":data,
		"id":id,
		"user":UserManager.getFullUsername(),
		"code":lobbyCode
	})

func _answer_received(id, answer):
	print("Got answer: %d" % id)
	if rtc_peer.has_peer(id):
		rtc_peer.get_peer(id).connection.set_remote_description("answer", answer)


func _candidate_received(id, mid, index, sdp):
	print("Got canidate")
	if rtc_peer.has_peer(id):
		rtc_peer.get_peer(id).connection.add_ice_candidate(mid, index, sdp)

func _createLobby():
	_send_data({"type":"createLobby","user":UserManager.getFullUsername()});

func _joinLobby(code):
	_send_data({"type":"joinLobby","user":UserManager.getFullUsername(),"code":code, "id":2});

func _process(delta):
	_client.poll()
"""

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
			print(receivedData.payload)
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
			print("mouseClicked")
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

"""
