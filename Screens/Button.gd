extends Control
 
func _on_Button_pressed():
	get_tree().change_scene("res://Screens/GameScene.tscn")
	
func _on_PlayButton2_pressed():
	get_tree().change_scene("res://Screens/GameScene.tscn")

func _on_LeaderboardButton_pressed():
	get_tree().change_scene("res://LeaderboardScene.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Screens/MainScene.tscn")
