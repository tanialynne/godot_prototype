extends Control

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.ui = self

func instance_popup(variation : int):
	var popup = load("res://scenes/popup.tscn").instance()
	call_deferred("add_child", popup)
	popup.variation = variation
