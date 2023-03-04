extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var transition = $"../Transition";

func _ready():
	pass;

func _on_PlayButton_pressed():
	$"../ButtonClickSFX".play();
	transition.transition_in("res://Screens/LevelSelect.tscn");

func _on_SettingsButton_pressed():
	$"../ButtonClickSFX".play();
	$"../SettingsPopupMenu".popup();

func _on_TutorialButton_pressed():
	$"../ButtonClickSFX".play();
	transition.transition_in("res://Screens/Tutorial.tscn");

func _on_MultiplayerButton_pressed():
	$"../ButtonClickSFX".play();
	transition.transition_in("res://Screens/Multiplayer/ConnectingServer.tscn");


func _on_CreditsButton_pressed():
	$"../ButtonClickSFX".play();
	transition.transition_in("res://Screens/Credits.tscn");
