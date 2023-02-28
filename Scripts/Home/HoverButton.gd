extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var buttonLabel = $"../../ButtonLabels";
onready var centerButton = (self.rect_position.x + self.rect_size.x/2)
onready var buttonLabelSize = buttonLabel.rect_size.x/2;
export var buttonName:String;
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "_on_Mouse_Enter")
	connect("mouse_exited", self, "_on_Mouse_Leave")

	buttonLabel.visible = false;

func _on_Mouse_Enter():
	modulate = Color("e5e5e5")
	buttonLabel.rect_position = Vector2(centerButton-buttonLabelSize, buttonLabel.rect_position.y)
	buttonLabel.visible = true;
	buttonLabel.bbcode_text="[center]%s[center]" % buttonName;
	

func _on_Mouse_Leave():
	modulate = Color("ffffff")
	buttonLabel.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
