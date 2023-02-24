extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var username = "";
var identifier = "#"

# Called when the node enters the scene tree for the first time.
func _ready():
	var user_data =  File.new()
	if not user_data.file_exists("user://userData.save"):
		pass;
	else:
		user_data.open("user://savegame.save", File.READ);
		while user_data.get_position() < user_data.get_len():
			# Get the saved dictionary from the next line in the save file
			var node_data = parse_json(user_data.get_line())
			
			username = node_data.username;
			identifier = node_data.identifier;
		user_data.close()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
