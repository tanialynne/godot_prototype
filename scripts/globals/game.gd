extends Node

var main : Node
var UI : CanvasLayer
var ui : Control 
var station : YSort
var tileMap : TileMap
var avatar : String = "res://textures/avatars/avatar_0.png"
var character : Area2D
var mobileChart : Area2D
var jake : Area2D
var uma : Area2D

var stringholder_characterName : String  = "PlayerName"

func _ready():
	if (JavaScript.get_interface("getPlayerName")):
		stringholder_characterName = JavaScript.eval("""
			getPlayerName();
		""")
