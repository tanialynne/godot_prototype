extends Control

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		call_deferred("free")
		Game.UI.call_deferred("add_child", load("res://scenes/avatarCreationScreen.tscn").instance())
