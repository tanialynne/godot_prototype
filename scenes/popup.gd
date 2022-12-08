extends PanelContainer

var variation : int
var texts : Dictionary = {
	0 : "Wellcome to the delivery station\nfloor. Before we start, let's give\nyou a quick tour.",
	1 : "This is you. In the game, it's\n your job as a manager to\ncoach your associates so they\nwork efficiently and respond to\nyou."
}

func _ready():
	$VBoxContainer/Button.connect("pressed", self, "on_Button_pressed")
	get_tree().paused = true
	$VBoxContainer/Label.set_text(texts[variation])
	
	if variation == 1:
		rect_position = Vector2(804.0, 210.0)
	else:
		set_anchors_and_margins_preset(Control.PRESET_CENTER)
		$Polygon2D.hide()

func on_Button_pressed():
	match(variation):
		0:
			Events.event_1()
		1:
			Events.event_2()
	
	get_tree().paused = false
	call_deferred("free")
