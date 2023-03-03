extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Resolutions: Dictionary = {"3840x2160":Vector2(3840,2160),
								"2560x1440":Vector2(2560,1080),
								"1920x1080":Vector2(1920,1080),
								"1366x768":Vector2(1366,768),
								"1536x864":Vector2(1536,864),
								"1280x720":Vector2(1280,720),
								"1440x900":Vector2(1440,900),
								"1600x900":Vector2(1600,900),
								"1024x600":Vector2(1024,600),
								"800x600": Vector2(800,600)}
								
var ResolutionArr:Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var CurrentResolution = get_viewport().get_size()

	var index = 0
	
	for r in Resolutions:
		$HFlowContainer/Resolutions.add_item(r, index)
		ResolutionArr.append(r);
		if Resolutions[r] == CurrentResolution:
			$HFlowContainer/Resolutions._select_int(index)
		index += 1
	
	var settingResolution = UserManager.settings.graphics.resolution;
	if($HFlowContainer/Resolutions.get_item_text($HFlowContainer/Resolutions.selected) != settingResolution):
		_on_Resolutions_item_selected(ResolutionArr.find(settingResolution))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Resolutions_item_selected(index):
	var size = Resolutions.get($HFlowContainer/Resolutions.get_item_text(index))
	OS.set_window_size(size)
	OS.center_window()	
	UserManager.settings.graphics.resolution = $HFlowContainer/Resolutions.get_item_text(index);
	UserManager.updateFile();
