extends TextureRect

func _ready():
	expand = true
	rect_min_size = Vector2(125.0, 140.0)
	
	if not get_position_in_parent() == 0:
		self_modulate.a = 0.3
		$selectionFrame.self_modulate.a = 0.0
	else:
		select()
	
	set_texture(load("res://textures/avatars/avatar_" + str(get_position_in_parent()) + ".png"))

func _on_TextureRect_mouse_entered():
	if $Tween.is_active():
		$Tween.stop_all()
	
	$Tween.interpolate_property(self, "self_modulate:a", self_modulate.a, 1.0, 0.15, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "rect_min_size", rect_min_size, Vector2(125.0, 140.0), 0.15, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()

func _on_TextureRect_mouse_exited():
	if $Tween.is_active():
		$Tween.stop_all()
	
	$Tween.interpolate_property(self, "self_modulate:a", self_modulate.a, 0.3, 0.15, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.interpolate_property(self, "rect_min_size", rect_min_size, Vector2(125.0, 140.0), 0.15, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()

func select():
	Game.avatar = texture.get_path()
	disconnect("mouse_entered", self, "_on_TextureRect_mouse_entered")
	disconnect("mouse_exited", self, "_on_TextureRect_mouse_exited")
	
	if $selectionFrame/Tween.is_active():
		$selectionFrame/Tween.stop_all()
	
	$selectionFrame/Tween.interpolate_property($selectionFrame, "self_modulate:a", $selectionFrame.self_modulate.a, 1.0, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
	$selectionFrame/Tween.start()

func deselect():
	connect("mouse_entered", self, "_on_TextureRect_mouse_entered")
	connect("mouse_exited", self, "_on_TextureRect_mouse_exited")
	
	if $selectionFrame/Tween.is_active():
		$selectionFrame/Tween.stop_all()
	
	$selectionFrame/Tween.interpolate_property($selectionFrame, "self_modulate:a", $selectionFrame.self_modulate.a, 0.0, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
	$selectionFrame/Tween.start()

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if $selectionFrame.self_modulate.a == 0:
			select()
		
			for child in get_parent().get_children():
				if not child == self and child.get_node("selectionFrame").self_modulate.a > 0.0:
					child.deselect()
					child._on_TextureRect_mouse_exited()
