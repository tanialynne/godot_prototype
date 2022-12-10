extends ColorRect

#Jake's test info
var jakeInfo = "Text placeholder..."

#Uma's test info
var umaInfo = "'Uma never usually makes a" \
+ "\nmistake with applying SAL's, but it" \
+ "\nsays here she's applied an" \
+ "\nincorrect SAL 24 times in just one" \
+ "\nhour! Something else must be" \
+ "\nwrong here.'"

func _ready():
	get_tree().paused = true
	$jake.connect("gui_input", self, "on_jake_gui_input")
	$uma.connect("gui_input", self, "on_uma_gui_input")
	$info/buttonReturnToFloor.connect("gui_input", self, "on_buttonReturnToFloor_gui_input")

func on_jake_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$info/character.texture = load("res://textures/assets_02_03/profile_jake.png")
		$info/name.text = "Jake"
		$info/Label.text = jakeInfo

func on_uma_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$info/character.texture = load("res://textures/assets_02_03/profile_uma.png")
		$info/name.text = "Uma"
		$info/Label.text = umaInfo

func on_buttonReturnToFloor_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		call_deferred("free")
		get_tree().paused = false
