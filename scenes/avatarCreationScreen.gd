extends TextureRect

var textureRect_selected = TextureRect.new()

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$button_go.connect("pressed", self, "on_button_go_pressed")
	
	#Instance Avatars
	for i in range(9):
		
		var avatarPreview = load("res://scenes/avatarPreview.tscn").instance()
		$GridContainer.call_deferred("add_child", avatarPreview)
	
func on_button_go_pressed():
	#Game.stringholder_characterName = $TextEdit.text
	call_deferred("free")
	Game.UI.call_deferred("add_child", load("res://scenes/control_loading.tscn").instance())
	
