extends Node2D

onready var links = $Links		# A slightly easier reference to the links
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip := Vector2(0,0)			# The global position the tip should be in

var currentLetter;

const SPEED = 20	# The speed with which the chain moves

var flying = false	
var hooked = false	


func shoot(dir: Vector2) -> void:
	if(!hooked):
		$"../../CollisionShape2D".disabled=true;
		direction = (dir - self.global_position).normalized()
		flying = true
		tip = self.global_position

# release() the chain
func release() -> void:
	if(!hooked):
		flying = false	# Not flying anymore	
		hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something
	if not self.visible:
		return	# Not visible -> nothing to draw
	var tip_loc = to_local(tip)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	$Links.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$Tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	links.position = tip_loc						# The links are moved to start at the tip
	links.region_rect.size.y = tip_loc.length()*1.5		# and get extended for the distance between (0,0) and the tip

# Every physics frame we update the tip position
func _physics_process(_delta: float) -> void:
	$Tip.global_position = tip	# The player might have moved and thus updated the position of the tip -> reset it
	if flying || hooked:
		# `if move__andcollide()` always moves, but returns true if we did collide
		var collision;
		if(hooked):
			
			collision = $Tip.move_and_collide(direction * SPEED * -1);
		else:
			collision = $Tip.move_and_collide(direction * SPEED);
		if collision:
			if(collision.collider.name=="LetterKin"):
				hooked = true	# Got something!
				flying = false	# Not flying anymore
				currentLetter = collision.collider.get_parent()._getLetter();
				$Tip/Letter.texture=load("res://Assets//Letters//Letter_"+currentLetter+".png")
				$Tip/Letter.visible=true;
				collision.collider.get_parent().queue_free();
				$"../../CollisionShape2D".disabled=false;
			elif (collision.collider.name=="DummyPlayer" && hooked):
				hooked = false;
				$Tip/Letter.visible=false;
			else:
				release()
	tip = $Tip.global_position	# set `tip` as starting position for next frame
