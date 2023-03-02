extends Node

# Purpose
# Store user based data such as username, identifier, client settings, etc.
# Data stored here is persistant as it is saved in 

const path = "user://userData.save";

# Default settings
class Settings:
	signal data_modified;
	
	var username = "";
	var identifier = "#"
	var modifiers = {
		"VowelDecrease":false,
		"LetterSpeedup":false,
		"TimeDecrease": false
	};
	var graphics = {
		"resolution":"1920x1080",
		"FXAA":false,
		"VSync":true
	}
	var volume = {
		"master": 50,
		"music": 50,
		"specialfx": 50
	}
	var watched = 0;
	var completedLevels = 0;
	
	# Get every property of the class and put that information into an dictionary
	func deseralizeData():
		var data = {}
		
		for n in getModifiedPropertyList():
			data[n] = self[n];
		
		return data;
	
	# Take JSON data and put that information into the class
	# JSON seralization; only seralize data from the JSON of variables that exist in the class
	func seralizeData(data:Dictionary):
		var propertyList = getModifiedPropertyList();
		for n in data:
			if n in propertyList:
				self[n] = data[n];

	# Get all variable properties of the class from the property list
	# Used to seralize/deseralize the class based on the JSON data received
	func getModifiedPropertyList():
		var propertyList = get_property_list()
		var modifiedPropertyList = [];
		for n in propertyList:
			if(n.usage == 8192):
				modifiedPropertyList.append(n.name)
		return modifiedPropertyList;
		

var settings:Settings = Settings.new();


var timer:Timer = Timer.new();
var randomWords = ["Simply"]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Timer to keep track of changes happening in a short period of time
	add_child(timer);

	var user_data =  File.new()
	if not user_data.file_exists(path):
		randomize()
		var generatedUsername = "SomeDefaultName";
		var generatedIdentifier = str((randi()%9999+1)).pad_zeros(4)
		
		writeData(settings.deseralizeData())

	else:
		user_data.open(path, File.READ);
		var data = JSON.parse(user_data.get_as_text()).result
		settings.seralizeData(data);
		user_data.close()

# Update the settings of the user based on the values set on GoDot
func updateFile():
	writeData(settings.deseralizeData());


# Write data to a specified path with a specified data
func writeData(data):
	var user_data =  File.new()
	user_data.open(path, File.WRITE);
	user_data.store_line(to_json(data))
	user_data.close();
	
# Returns the username in proper formato f Username#0000 (Identifier)
func getFullUsername():
	return settings.username + "#" + settings.identifier;
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
