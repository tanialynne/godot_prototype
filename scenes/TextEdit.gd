extends TextEdit

var maximum_characters = 10
var current_text = ''
var cursor_line = 0
var cursor_column = 0

func _ready():
	connect("text_changed", self, "_on_TextEdit_text_changed")

func _on_TextEdit_text_changed():
	var new_text : String = text
	if new_text.length() > maximum_characters:
		text = current_text
		cursor_set_line(cursor_line)
		cursor_set_column(cursor_column)

	current_text = text
	cursor_line = cursor_get_line()
	cursor_column = cursor_get_column()
