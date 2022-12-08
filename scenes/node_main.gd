extends Node

func _ready():
	Game.main = self
	call_deferred("add_child", load("res://scenes/textureRect_background.tscn").instance())
