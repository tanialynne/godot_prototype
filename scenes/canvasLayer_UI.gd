extends CanvasLayer

func _ready():
	Game.UI = self
	call_deferred("add_child", load("res://scenes/welcomeScreen.tscn").instance())
