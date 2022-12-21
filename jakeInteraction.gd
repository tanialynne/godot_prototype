extends Control

func _ready():
	$buttonReturnToFloor.hide()

func _on_buttonReturnToFloor_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		Game.jake.disable_interaction()
		call_deferred("free")
