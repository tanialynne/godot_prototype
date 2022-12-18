extends ColorRect

#Jake's test info
var jakeInfo = "'Jake’s working extremely quickly but it also seems he’s making a few errors. It says here he’s applied six incorrect SALs in two hours. Maybe I should go over and take a look.'"

#Uma's test info
var umaInfo = "'Uma never usually makes a" \
+ "\nmistake with applying SAL's, but it" \
+ "\nsays here she's applied an" \
+ "\nincorrect SAL 24 times in just one" \
+ "\nhour! Something else must be" \
+ "\nwrong here.'"

var jakeInput = false
var umaInput = false
var animationPlayed = false

func _ready():
	get_tree().paused = true
	$jake.connect("gui_input", self, "on_jake_gui_input")
	$uma.connect("gui_input", self, "on_uma_gui_input")

func on_jake_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$info/character.texture = load("res://textures/assets_02_03/profile_jake.png")
		$info/name.text = "Jake"
		$info/Label.text = jakeInfo
		$jake/outline.show()
		$uma/outline.hide()
		
		if not animationPlayed:
			$AnimationPlayer.play("default")
			animationPlayed = true
		
		jakeInput = true
		
		if jakeInput and umaInput:
			$info/buttonReturnToFloor.texture = load("res://textures/assets_02_03/button_active.png")
			$info/buttonReturnToFloor.connect("gui_input", self, "on_buttonReturnToFloor_gui_input")

func on_uma_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$info/character.texture = load("res://textures/assets_02_03/profile_uma.png")
		$info/name.text = "Uma"
		$info/Label.text = umaInfo
		$uma/outline.show()
		$jake/outline.hide()
		
		if not animationPlayed:
			$AnimationPlayer.play("default")
			animationPlayed = true
		
		umaInput = true
		
		if umaInput and jakeInput:
			$info/buttonReturnToFloor.texture = load("res://textures/assets_02_03/button_active.png")
			$info/buttonReturnToFloor.connect("gui_input", self, "on_buttonReturnToFloor_gui_input")

func on_buttonReturnToFloor_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		Events.event_5()
		call_deferred("free")
		get_tree().paused = false

