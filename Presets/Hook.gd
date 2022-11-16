extends Node2D


onready var links = $Link

var direction := Vector2(0,0)
var tip := Vector2(0,0)

const SPEED = 50

var flying = false
var itemHooked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot(dir: Vector2) -> void:
	direction = dir.normalized()
	flying = true
	tip = self.global_position
	
func _process(_delta: float) -> void:
	self.visible = flying or itemHooked
	if not self.visible:
		return
	var tip_loc = to_local(tip)
	
	links.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$Tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	links.position = tip_loc
	links.region_rect.size.y = tip_loc.length()

func _physics_process(_delta: float) -> void:
	$Tip.global_position = tip
	if flying:
		if $Tip.move_and_collide(direction * SPEED):
			itemHooked = true
			flying = false
	tip = $Tip.global_position

func release() -> void:
	flying = false	# Not flying anymore	
	itemHooked = false	# Not attached anymore
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
