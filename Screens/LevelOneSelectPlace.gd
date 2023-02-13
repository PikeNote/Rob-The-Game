extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startingY = 0;
var increasing = false;

var assets = [
	"res://Assets/TravelInProgress/Level_One_Select_Place.png",
	"res://Assets/TravelInProgress/Level_Two_Select_Place.png",
	"res://Assets/TravelInProgress/Level_Three_Select_Place.png"
]

var gameLevels = [
	"res://Screens/GameScene.tscn",
	"res://Screens/LevelTwo.tscn",
	"res://Screens/LevelThree.tscn"
]

var properItem;
var pathFollow;

var levelSwitching = false;

onready var transition = $"../Transition"

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".texture=load(assets[GlobalVars.currentScene]);
	$"../EnterPath".visible = false;
	$"../ExitPath".visible = false;
	if(!GlobalVars.endGame):
		properItem = $"../EnterPath";
		pathFollow = $"../EnterPath/PathFollow2D"
	else:
		properItem = $"../ExitPath";
		pathFollow = $"../ExitPath/PathFollow2D"
	properItem.visible = true;
	pathFollow.unit_offset = 0;
	startingY = properItem.transform.y;
	$"../AnimationPlayer".get_animation("JumpingRob").loop = true;
	$"../AnimationPlayer".play("JumpingRob");
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	if(pathFollow.unit_offset<=0.95):
		pathFollow.unit_offset+=0.004;
		if(pathFollow.unit_offset>=0.8):
			$"../AnimationPlayer".get_animation("JumpingRob").loop = false;
	else:
		if(!levelSwitching):
			if(!GlobalVars.endGame):
				transition.transition_in(gameLevels[GlobalVars.currentScene]);
			else: 
				GlobalVars.endGame = false;
				transition.transition_in("res://Screens/LevelSelect.tscn");
				levelSwitching=true;
		
		
		
		
