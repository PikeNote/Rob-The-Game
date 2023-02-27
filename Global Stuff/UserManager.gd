extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var username = "";
var identifier = "#"

var randomWords = ["Simply"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var user_data =  File.new()
	if not user_data.file_exists("user://userData.save"):
		randomize()
		var generatedUsername = "SomeDefaultName";
		var generatedIdentifier = str((randi()%9999+1)).pad_zeros(4)
		
		var user_json = {
			"username":generatedUsername,
			"identifier":generatedIdentifier
		}
		
		writeData(user_data,"user://userData.save",user_json)
		
		username = generatedUsername;
		identifier = generatedIdentifier;
		
		
		pass;
	else:
		user_data.open("user://userData.save", File.READ);
		while user_data.get_position() < user_data.get_len():
			# Get the saved dictionary from the next line in the save file
			var node_data = parse_json(user_data.get_line())
			
			username = node_data.username;
			identifier = node_data.identifier;
		user_data.close()
	pass # Replace with function body.

func writeData(user_data, path, data):
	user_data.open(path, File.WRITE);
	user_data.store_line(to_json(data))
	user_data.close();
	
func getFullUsername():
	return username + "#" + identifier;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
