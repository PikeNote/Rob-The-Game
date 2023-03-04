extends Control

onready var transition = $"../../../Transition";

func _on_Button_pressed():
	transition.transition_in("res://Screens/Tutorial.tscn")
	
func _on_PlayButton2_pressed():
	transition.transition_in("res://Screens/LevelSelect.tscn")

func _on_LeaderboardButton_pressed():
	transition.transition_in("res://addons/silent_wolf/Scores/Leaderboard.tscn")

func _on_BackButton_pressed():
	transition.transition_in("res://Screens/MainScene.tscn")

func _on_CloseButton_pressed():
	transition.transition_in("res://Screens/MainScene.tscn")

func _on_LevelSelectExit_pressed():
	transition.transition_in("res://Screens/MainScene.tscn")

func _on_TutorialExit_pressed():
	transition.transition_in("res://Screens/MainScene.tscn")

