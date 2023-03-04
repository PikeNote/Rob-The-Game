extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity: Vector2
var yValue = 0;

var currentPlace = 0;
var moving = false;

var movingLeft = true;

onready var robScale = $"../RobSideProfile".scale.x;


onready var transition = $"../Transition";

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../AnimationPlayer".play("JumpingRob");
	#$"../AnimationPlayer".seek(0,true);
	$"../AnimationPlayer".stop(true);
	_doneMoving(0);
	pass # Replace with function body.
	
func _physics_process(delta):
	if(moving):
		if($"../RobSideProfile".scale.x > 0):
			$".".rotation_degrees += 0.5;
		else:
			$".".rotation_degrees -= 0.5;
		$"../LevelSelect".visible = false;
	else:
		$"../LevelSelect".visible = true;
	#$"../LevelSelect".visible = true;

func _pauseLoop():
		$"../AnimationPlayer".get_animation("JumpingRob").loop = false;

func _getCurrentPlace():
	return currentPlace;

func _moveNextLocation():
	moving = true;
	$"../AnimationPlayer".get_animation("JumpingRob").loop = true;
	$"../AnimationPlayer".play("JumpingRob")
	

func _doneMoving(index):
	$"../LevelSelect/Panel1/Title".bbcode_text = "[center]" + GameParameters.levelDescription[index].Name + "[/center]";
	$"../LevelSelect/Panel1/Description".text = GameParameters.levelDescription[index].Description;
	var starsCount = 1;
	for stars in $"../LevelSelect/Panel1/CenterStars/Stars".get_children():
		if(starsCount<=GameParameters.levelDescription[index].Difficulty):
			starsCount+=1;
			stars.modulate = Color(249, 255, 1);
		else:
			stars.modulate = Color(0, 0, 0);
	$"../LevelSelect/Panel2/Leaderboard"._loadData(GameParameters.levelDescription[index].Name);
	moving = false;
	currentPlace = index;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SelectLevel_button_down():
	GameReferences.currentScene = currentPlace;
	transition.transition_in("res://Screens/TravelInProgress.tscn");
	pass # Replace with function body.


func _on_LeftButton_pressed():
	$"../RobSideProfile".scale.x=robScale;
	_moveNextLocation();
	pass # Replace with function body.


func _on_RightButton_pressed():
	$"../RobSideProfile".scale.x=robScale*-1;
	_moveNextLocation();
	pass # Replace with function body.
