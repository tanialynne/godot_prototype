extends YSort

func _ready():
	Game.station = self
	yield(get_tree(), "idle_frame")
	Game.ui.instance_popup(0)
