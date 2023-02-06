extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal transition_in_done
signal transition_out_done
 
var queuedScene = "";
 
onready var animation_player = $Transition/TransitionAnimationPlayer

func _ready():
	visible = true;
	animation_player.play("transition_out")
 
func transition_in(scene):
	queuedScene = scene;
	$Transition/TransitionAnimationPlayer.play("transition_in")

func _on_TransitionAnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_in":
		get_tree().change_scene_to(load(queuedScene))
	elif anim_name == "transition_out":
		emit_signal("transition_out_done")
