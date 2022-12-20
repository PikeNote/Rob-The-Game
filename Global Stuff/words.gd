extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var words;
# Called when the node enters the scene tree for the first time.
func _ready():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	var error = http_request.request("https://raw.githubusercontent.com/dwyl/english-words/master/words_dictionary.json")
	

func _http_request_completed(result, response_code, headers, body):
	words = parse_json(body.get_string_from_utf8())
	words.erase("a");

func _checkWord(wd):
	return words.has(wd);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
