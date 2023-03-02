extends TextureButton


onready var modifier = $"..".name;
onready var descriptionBox = $"../../../Description";
onready var description = descriptionBox.get_node("Description");
onready var pointsMultiplier = descriptionBox.get_node("Multiplier").get_node("PointsMultiplier")

func _ready():
	connect("mouse_entered", self, "_on_Mouse_Enter")
	connect("mouse_exited", self, "_on_Mouse_Leave")
	pass

func _on_Mouse_Enter():
	modulate = Color("e5e5e5");
	
	description.text = GameParameters.modifiers[modifier].description;
	# Format: %dx or rather [num]x
	pointsMultiplier.text = "%sx" % GameParameters.modifiers[modifier].points_multiplier;
	
	descriptionBox.visible  = true;
	
	

func _on_Mouse_Leave():
	modulate = Color("ffffff")
	descriptionBox.visible  = false;
