extends Timer

export(int) var minutes = 1;
export(int) var seconds = 2; 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timeInSeconds = 0;
onready var ConfirmUsername = $"../ConfirmUsername"

# Called when the node enters the scene tree for the first time.
func _ready():
	timeInSeconds = (minutes*60)+seconds;
	connect("timeout",self,"_passTime")

func _passTime():
	timeInSeconds -= 1;
	var sec = timeInSeconds%60;
	var minu = (timeInSeconds/60)%60;
	$"..".text="Remaining time:\n"+"%02d:%02d" % [minu, sec]
	if $"../ClockTimerText/ClockTimer".returnTime() == 0:
		print("There are 0 seconds on the clock");
		ConfirmUsername.popup();

func returnTime():
	return timeInSeconds

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
