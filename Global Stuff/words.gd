extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var words;
var wordValueTable = {
	"A":1,
	"B":3,
	"C":3,
	"D":2,
	"E":1,
	"F":4,
	"G":2,
	"H":4,
	"I":1,
	"J":8,
	"K":5,
	"L":1,
	"M":3,
	"N":1,
	"O":1,
	"P":3,
	"Q":10,
	"R":1,
	"S":1,
	"T":1,
	"U":1,
	"V":4,
	"W":4,
	"X":8,
	"Y":4,
	"Z":10
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	var error = http_request.request("http://www.mieliestronk.com/corncob_lowercase.txt")
	print("List loaded!")
	

func _http_request_completed(result, response_code, headers, body):
	words = body.get_string_from_utf8().split("\n");
	print(words.size())
	print("Loading done!")
	#for key in words: # Remove all words that are less than 1 letter long
	#	if(key.length() == 1):
	#		words.erase(key)

func _checkWord(wd):
	if(wd.length() != 1):
		wd = wd.to_lower();
		var pnt = 0;
		var hasWord = words.has(wd);
		print(wd)
		if(hasWord):
			wd = wd.to_upper();
			for i in wd.length():
				pnt += wordValueTable[wd[i]];
				print(pnt)
				
		return [hasWord,pnt];
	else:
		return [false,0];

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
