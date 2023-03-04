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
	var error = http_request.request("https://raw.githubusercontent.com/jeremy-rifkin/Wordlist/master/res/d.txt")
	print("Word list loaded!")


func _http_request_completed(result, response_code, headers, body):
	words = body.get_string_from_utf8().split("\n");
	for i in words.size():
		words[i] = words[i].strip_edges(true, true)
	print(words.size())
	print("Loading done!")

func _checkWord(wd):
	# Do not accept words that are 1 character long
	if(wd.length() == 1):
		return [false,0];

	wd = wd.to_lower();
	var pnt = 0;
	var hasWord = words.has(wd);
	if(hasWord):
		wd = wd.to_upper();
		
		for i in wd.length():
			pnt += wordValueTable[wd[i]];
			
		pnt *= GameReferences.multiplier;
		return [hasWord,pnt];
	else:
		return [false,0];


