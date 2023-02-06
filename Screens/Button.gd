extends Control

onready var transition = $"../../../Transition";

func _on_Button_pressed():
	transition.transition_in("res://Screens/GameScene.tscn")
	
func _on_PlayButton2_pressed():
	transition.transition_in("res://Screens/LevelSelect.tscn")

func _on_LeaderboardButton_pressed():
	transition.transition_in("res://Screens/LeaderboardScene.tscn")

func _on_BackButton_pressed():
	transition.transition_in("res://Screens/MainScene.tscn")
