extends Control

var loader
var nodePath : NodePath

func _ready():
	nodePath = "res://scenes/world.tscn"
	loader = ResourceLoader.load_interactive(nodePath)
	$TextureProgress.max_value = loader.get_stage_count()

func _process(delta):
	$TextureProgress.value = loader.get_stage()
	var err = loader.poll()
	
	if err == ERR_FILE_EOF:
		var scene = loader.get_resource().instance()
		Game.main.call_deferred("add_child", scene)
		Game.UI.call_deferred("add_child", load("res://scenes/ui.tscn").instance())
		Game.main.get_node("textureRect_background").call_deferred("free")
		call_deferred("free")
	
	if not $VideoPlayer.is_playing():
		$VideoPlayer.play()
