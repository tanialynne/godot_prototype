extends TextureRect
class_name Response
tool

export(String) var text = "Text..." setget set_text
export(bool) var correctAnswer = false
export(int) var adaptability = 0
export(int) var listening  = 0
export(int) var clarity = 0
export(int) var feedback = 0

func set_text(new_text):
	$Label.text = new_text
	text = new_text

func _on_Response_mouse_entered():
	texture = load("res://textures/interaction/option_panel_active.png")

func _on_Response_mouse_exited():
	texture = load("res://textures/interaction/option_panel_inactive.png")

func _on_Response_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if correctAnswer:
			$questionMark.texture = load("res://textures/interaction/correct_icon.png")
		else:
			$questionMark.texture = load("res://textures/interaction/incorrect_icon.png")
		
		Game.character.adaptability_current += adaptability
		Game.character.listening_current += listening
		Game.character.clarity_current += clarity
		Game.character.feedback_current += feedback
		
		for child in get_parent().get_children():
			child.disconnect("mouse_entered", child, "_on_Response_mouse_entered")
			child.disconnect("mouse_exited", child, "_on_Response_mouse_exited")
			child.disconnect("gui_input", child, "_on_Response_gui_input")
		
		get_parent().get_parent().get_node("buttonReturnToFloor").show()
