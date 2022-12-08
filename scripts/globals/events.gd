extends Node

func _ready():
	pass

func event_0():
	yield(get_tree().create_timer(1.0),"timeout")	
	Station.truck_0.move()
	yield(get_tree().create_timer(1.0),"timeout")
	Station.truck_1.move()
	yield(get_tree().create_timer(3.0),"timeout")
	Game.ui.instance_popup(0)

func event_1():
	Game.ui.instance_popup(1)

func event_2():
	Game.character.set_process(true)
	Game.character.set_process_unhandled_input(true)
