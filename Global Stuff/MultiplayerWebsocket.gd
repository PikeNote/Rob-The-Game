extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var websocket_url = "wss://rob-server.pikenote.repl.co"

# Our WebSocketClient instance
var _client = WebSocketClient.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")

	var err = _client.connect_to_url(websocket_url, ["lws-mirror-protocol"])
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _createLobby():
	_client.get_peer(1).put_packet({
	  "type":"createLobby"});
	

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	

func _on_data():
	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())

func _process(delta):
	_client.poll()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
