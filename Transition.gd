extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal transition_in_done
signal transition_out_done
 
 
onready var animation_player = $Transition/TransitionAnimationPlayer


 
func transition_in():
	$Transition/TransitionAnimationPlayer.play("transition_in")
 
 
func transition_out():
	animation_player.play("transition_out")
 

func _on_TransitionAnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_in":
		emit_signal("transition_in_done")
	elif anim_name == "transition_out":
		emit_signal("transition_out_done")
