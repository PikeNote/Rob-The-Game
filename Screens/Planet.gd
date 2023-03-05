extends Sprite

var velocity: Vector2
var yValue = 0;

var moveTo;

var moving = false;

var movingLeft = true;

onready var robScale = $"../RobSideProfile".scale.x;
onready var transition = $"../Transition";
onready var leftButton = $"../LevelSelect/LevelPanel/ButtonContainer/VBoxContainer/MapSelectButtons/LeftButton";
onready var rightButton = $"../LevelSelect/LevelPanel/ButtonContainer/VBoxContainer/MapSelectButtons/RightButton"
# Rotations are in degrees
var rotationalCheckpoints = [-42.9,69.4,214.7];

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../AnimationPlayer".play("JumpingRob");
	$"../AnimationPlayer".seek(0,true);
	$"../AnimationPlayer".stop(true);
	_doneMoving(GameReferences.currentScene);
	$".".rotation_degrees = rotationalCheckpoints[GameReferences.currentScene]
	
func _physics_process(delta):
	if(moving):
		if($"../RobSideProfile".scale.x > 0):
			$".".rotation_degrees += 0.5;
			
			# Stop animation when it is about to approach a certain rotational degree on the planet
			if($".".rotation_degrees >= rotationalCheckpoints[moveTo]):
				moving = false;
				_pauseLoop();
		else:
			$".".rotation_degrees -= 0.5;
			
			# Stop animation when it is about to approach a certain rotational degree on the planet
			if($".".rotation_degrees <= rotationalCheckpoints[moveTo]):
				moving = false;
				_pauseLoop();
		
		

func _pauseLoop():
		$"../AnimationPlayer".get_animation("JumpingRob").loop = false;



func _moveNextLocation(movingBackwards:bool=false):
	$"../LevelSelect".visible = false;
	moving = true;
	$"../AnimationPlayer".get_animation("JumpingRob").loop = true;
	$"../AnimationPlayer".play("JumpingRob")
	if(!movingBackwards):
		moveTo = GameReferences.currentScene + 1;
	else:
		moveTo = GameReferences.currentScene - 1;
	

func _doneMoving(index):	
	$"../LevelSelect/LevelPanel/Headers/Title".bbcode_text = "[center]%s[/center]" % GameParameters.levelDescription[index].Name;
	$"../LevelSelect/LevelPanel/Description".bbcode_text = "[center]%s[/center]" % GameParameters.levelDescription[index].Description;
	
	var starsCount = 1;
	for stars in $"../LevelSelect/LevelPanel/Headers/Stars".get_children():
		if(starsCount<=GameParameters.levelDescription[index].Difficulty):
			starsCount+=1;
			stars.modulate = Color(249, 255, 1);
		else:
			stars.modulate = Color(0, 0, 0);
	
	$"../LevelSelect/LeaderboardPanel/Leaderboard"._loadData(GameParameters.levelDescription[index].Name);
	
	var requirements = GameParameters.levelDescription[index].Requirements;
	$"../LevelSelect/LevelPanel/Headers/LevelRequirements/Requirements".bbcode_text = "[center] Spell %s words - Get %s points[/center]" % [requirements.spelled,requirements.points];
	
	moving = false;
	GameReferences.currentScene = index;
	
	rightButton.visible = true;
	leftButton.visible = true;
	
	# Disable buttons as needed if there is no next/previous level
	if(GameReferences.currentScene <= 0):
		rightButton.visible = false;
	
	if(GameReferences.currentScene >=rotationalCheckpoints.size()-1):
		leftButton.visible = false;
	
	# Enable the level info menu once again
	$"../LevelSelect".visible = true;

func _on_SelectLevel_button_down():
	$"../ButtonClickSFX".play();
	transition.transition_in("res://Screens/TravelInProgress.tscn");

func _on_LeftButton_pressed():
	# Check if the user has compelted the current level
	if(GameParameters.levelDescription[GameReferences.currentScene].Name in UserManager.settings.levelsCompleted):
		$"../ButtonClickSFX".play();
		$"../RobSideProfile".scale.x=robScale;
		_moveNextLocation();

func _on_RightButton_pressed():
	$"../ButtonClickSFX".play();
	$"../RobSideProfile".scale.x=robScale*-1;
	_moveNextLocation(true);

func _on_AnimationPlayer_animation_finished(anim_name):
	if !moving:
		$"../AnimationPlayer".stop(true);
		_doneMoving(moveTo);
