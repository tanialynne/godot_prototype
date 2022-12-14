extends Node

func _ready():
	pass

func event_0():
#	yield(get_tree().create_timer(1.0),"timeout")
#	Station.truck_0.move()
#	yield(get_tree().create_timer(1.0),"timeout")
#	Station.truck_1.move()
#	yield(get_tree().create_timer(3.0),"timeout")
	Game.ui.instance_popup(0)

func event_1():
	var arrow = load("res://scenes/arrowDown.tscn").instance()
	Game.ui.call_deferred("add_child", arrow)
	arrow.rect_position = Vector2(900, 220)
	arrow.name = "arrow"
	Game.ui.instance_popup(1)

func event_2():
	Game.ui.get_node("arrow").call_deferred("free")
	var infoIcon = load("res://scenes/infoIcon.tscn").instance()
	Game.mobileChart.call_deferred("add_child", infoIcon)
	infoIcon.position.y -= 128.0
	infoIcon.name = "infoIcon"
	Game.ui.instance_popup(2)

func event_3():
	Game.character.set_process(true)
	Game.character.set_process_unhandled_input(true)
	Game.ui.instance_popup(3)
	
	#Development...
	var shaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = load("res://shaders/outline.shader")
	Game.station.get_node("placeholder_0").material = shaderMaterial
	Game.station.get_node("placeholder_1").material = shaderMaterial

func event_4():
	Game.station.get_node("placeholder_0").material = null
	Game.station.get_node("placeholder_1").material = null
