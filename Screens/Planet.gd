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
	yValue = $"../KinematicBody2D".position.y;
	_doneMoving(0);
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity += Vector2.DOWN * 14.0 * delta;
	
	if(moving):
		if($"../KinematicBody2D".position.y>=yValue):
			velocity = Vector2.UP * 7.0;
		$"../Planet-transformed".rotation_degrees += 0.5;
		$"../LevelSelect".visible = false;
	else:
		$"../LevelSelect".visible = true;
	$"../KinematicBody2D".move_and_collide(velocity);
	#$"../LevelSelect".visible = true;
		
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

func _doneMoving(index):
	$"../LevelSelect/Title".bbcode_text = "[center]" + levelDescription[index].Name + "[/center]";
	$"../LevelSelect/Description".text = levelDescription[index].Description;
	var starsCount = 0;
	for stars in $"../LevelSelect/CenterStars".get_children():
		if(starsCount<=levelDescription[index].Difficulty):
			starsCount+=1;
			stars.modulate = Color(249, 255, 1);
		else:
			stars.modulate = Color(0, 0, 0);
	print(index)
	moving = false;
	currentPlace = index;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
