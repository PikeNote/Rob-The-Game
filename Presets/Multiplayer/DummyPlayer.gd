extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var overUI = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	

func _changeOverUI(b):
	overUI = b;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if(not $Lasso.visible):
		self.look_at($"../../Player2MousePos".position)
		self.rotation_degrees -= 90
		#var angle = ($"../../Player2MousePos".position - self.global_position).angle()
		#self.global_rotation = lerp_angle(self.global_rotation, angle-(PI/2), delta)
		#$".".look_at($"../../Player2MousePos".position)
		#$".".rotation_degrees -= 90

func emulateLasso(s):
	$Lasso.changeLasso(s);
	pass;

func _shoot(pos):
	$Lasso.shoot(pos);

func _release():
	$Lasso.release();


