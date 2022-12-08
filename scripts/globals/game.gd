extends Node

var main : Node
var UI : CanvasLayer
var ui : Control 
var station : YSort
var avatar : String = "res://textures/avatars/avatar_0.png"
var character : Area2D
var stringholder_characterName : String  = "Player"

func _ready():
	if (JavaScript.get_interface("getPlayerName")):
		stringholder_characterName = JavaScript.eval("""
			getPlayerName();
		""")	


func _process(delta):
	pass
