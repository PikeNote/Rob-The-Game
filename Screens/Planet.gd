extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity: Vector2
var yValue = 0;

var currentPlace = 0;
var moving = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../AnimationPlayer".stop();
	$"../AnimationPlayer".get_animation("JumpingRob").loop = false;
	_doneMoving(0);
	pass # Replace with function body.
	
func _physics_process(delta):
	if(moving):
		$"../Planet-transformed".rotation_degrees += 0.5;
		$"../LevelSelect".visible = false;
	else:
		$"../LevelSelect".visible = true;
	#$"../LevelSelect".visible = true;

func _pauseLoop():
		$"../AnimationPlayer".get_animation("JumpingRob").loop = false;

var levelDescription = [
	{
		"Name":"Farm",
		"Difficulty":1,
		"Description":"Rob's journey begins here",
		"LevelName":"res://Screens/GameScene.tscn"
	},
	{
		"Name":"Crossroads",
		"Difficulty":2,
		"Description":"Passing on the roads",
		"LevelName":"res://Screens/LevelTwo.tscn"
	},
	{
		"Name":"Broadway",
		"Difficulty":3,
		"Description":"Final destination: Broadway",
		"LevelName":"res://Screens/LevelThree.tscn"
	},
]


func _getCurrentPlace():
	return currentPlace;

func _moveNextLocation():
	moving = true;
	$"../AnimationPlayer".get_animation("JumpingRob").loop = true;
	$"../AnimationPlayer".play("JumpingRob")

func _doneMoving(index):
	$"../LevelSelect/Title".bbcode_text = "[center]" + levelDescription[index].Name + "[/center]";
	$"../LevelSelect/Description".text = levelDescription[index].Description;
	var starsCount = 1;
	for stars in $"../LevelSelect/CenterStars/Stars".get_children():
		print(stars.name)
		print(starsCount)
		if(starsCount<=levelDescription[index].Difficulty):
			starsCount+=1;
			stars.modulate = Color(249, 255, 1);
		else:
			stars.modulate = Color(0, 0, 0);
	moving = false;
	currentPlace = index;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SelectLevel_button_down():
	get_tree().change_scene_to(load(levelDescription[currentPlace].LevelName))
	pass # Replace with function body.
