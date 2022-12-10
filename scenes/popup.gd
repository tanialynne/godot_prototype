extends TextureRect

var variation : int
var texts : Dictionary = {
	0 : "Welcome to the delivery\nstation floor. Before we\nstart, let's give you a\nquick tour.",
	1 : "This is you. In this game,\nit's your job as a leader\nto coach your associates\nso they work\nefficiently\nand respond to you.",
	2 : "The mobile cart has an\nicon above it whitch\nshows you it's the next\nthing you need\nto explore.",
	3 : "You can also interact\nwith any item that's\nflashing like this.\nClick on any item to\ninteract with it."
}

func _ready():
	get_tree().paused = true
	$buttonNext.connect("gui_input", self, "on_buttonNext_gui_input")
	$info.set_text(texts[variation])
	
	if variation in [0, 1, 2]:
		$buttonNext/text.text = "Next"
	elif variation in [3]:
		$buttonNext/text.text = "Close"

func on_buttonNext_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		call_deferred("free")
		
		match(variation):
			0:
				Events.event_1()
			1 : 
				Events.event_2()
			2:
				Events.event_3()
		
		get_tree().paused = false
