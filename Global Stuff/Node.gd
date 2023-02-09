extends Node

func _ready():
	SilentWolf.configure({
	"api_key": "GHazTAmQ4K85iZvMNmunxOdZYMxCGZ79LJB3a80g",
	"game_id": "BIGBOYROB",
	"game_version": "1.0.2",
	"log_level": 1})
	SilentWolf.configure_scores({"open_scene_on_close": "res://scenes/MainPage.tscn"})

