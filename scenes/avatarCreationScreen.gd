extends TextureRect

var textureRect_selected = TextureRect.new()

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$textureButton_go.connect("pressed", self, "on_textureButton_go_pressed")
	
	#Instance Avatars
	for i in range(9):
		var textureRect = TextureRect.new()
		$GridContainer.call_deferred("add_child", textureRect)
		textureRect.set_texture(load("res://textures/avatars/avatar_" + str(i) + ".png"))
		textureRect.name = "avatar_" + str(i)
		textureRect.connect("mouse_entered", self, "on_textureRect_mouse_entered", [textureRect])
		textureRect.connect("mouse_exited", self, "on_textureRect_mouse_exited", [textureRect])
		textureRect.connect("gui_input", self, "on_textureRect_gui_input", [textureRect])
	
	yield(get_tree(), "idle_frame")
	call_deferred("add_child", textureRect_selected)
	textureRect_selected.texture = load("res://textures/ui/avatar_selection.png")
	yield(get_tree(), "idle_frame")
	textureRect_selected.rect_global_position = $GridContainer.get_child(0).get_global_transform_with_canvas().origin
	textureRect_selected.rect_position -= Vector2(11, 11)

func _process(delta):
	return
	if $TextEdit.text == "":
		$TextEdit/Label.show()
		$textureButton_go.set_deferred("disabled", true)
	else:
		$TextEdit/Label.hide()
		$textureButton_go.set_deferred("disabled", false)

func on_textureRect_mouse_entered(textureRect : TextureRect):
	pass

func on_textureRect_mouse_exited(textureRect : TextureRect):
	pass

func on_textureRect_gui_input(event, textureRect : TextureRect):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		textureRect_selected.rect_global_position = textureRect.get_global_transform_with_canvas().origin
		textureRect_selected.rect_position -= Vector2(11, 11)
		Game.avatar = textureRect.texture.get_path()
		
func on_textureButton_go_pressed():
	#Game.stringholder_characterName = $TextEdit.text
	call_deferred("free")
	Game.UI.call_deferred("add_child", load("res://scenes/control_loading.tscn").instance())
	
