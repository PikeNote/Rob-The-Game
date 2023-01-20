extends Node2D

onready var popup = $PopupMenu

func _process(delta):
	popup.rect_global_position = self.position
