extends TextureButton
tool

export(String) var text = "Text..." setget set_text

func set_text(new_text):
	text = new_text
	$Label.set_text(text)

func _ready():
	$Label.mouse_filter = Control.MOUSE_FILTER_PASS
