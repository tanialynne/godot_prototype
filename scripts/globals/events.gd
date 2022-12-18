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
	Game.mobileChart.enable_interaction()

func event_5():
	Game.mobileChart.get_node("infoIcon").call_deferred("free")
	Game.mobileChart.disable_interaction()
	Game.jake.enable_interaction()
	
	var infoIcon = load("res://scenes/infoIcon.tscn").instance()
	Game.jake.call_deferred("add_child", infoIcon)
	infoIcon.position.y -= 128.0
	infoIcon.name = "infoIcon"
	
	var infoLabel = Label.new()
	Game.jake.call_deferred("add_child", infoLabel)
	infoLabel.text = "Click here to\ninteract with Jake."
	infoLabel.rect_size = Vector2(256.0, 128.0)
	infoLabel.rect_position = Vector2(-128.0, -320.0)
	infoLabel.align = true
	infoLabel.valign = true
	var dynamicFont = DynamicFont.new()
	dynamicFont.font_data = load("res://fonts/agency-fb-bold.ttf")
	infoLabel.set("custom_fonts/font", dynamicFont)
	infoLabel.set("cusom_colors/font_color_shadow", true)
	infoLabel.get("custom_fonts/font").set_size(28)
	infoLabel.name = "infoLabel"

func event_6():
	Game.jake.get_node("infoIcon").call_deferred("free")
	Game.jake.get_node("infoLabel").call_deferred("free")
