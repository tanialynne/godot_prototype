extends Area2D

onready var tileMap = get_parent().get_node("tileMap_terrain")
var path : Array
var goal : Area2D
var character : String = Game.stringholder_characterName
var speed : int = 150
var adaptability_maximum : int = 100
var adaptability_current : int = 50
var listening_maximum : int = 100
var listening_current : int = 50
var clarity_maximum : int = 100
var clarity_current : int = 50
var feedback_maximum : int = 100
var feedback_current : int = 50
var dir : String = "southwest"

func _ready():
	var selfCell = tileMap.world_to_map(position)
	position = tileMap.map_to_world(selfCell)
	position.y += tileMap.cell_size.y / 2
	set_process(false)
	set_process_unhandled_input(false)
	Game.character = self
	call_deferred("add_child", load("res://scenes/camera.tscn").instance())

func _process(delta):
	if path.size() > 0:
		var target_position = tileMap.map_to_world(path[0])
		target_position.y += tileMap.cell_size.y / 2
		
		var direction = (target_position - global_position).normalized()
		position += direction * speed * delta
		
		var self_cell = tileMap.world_to_map(position)
		
		if path[0] == self_cell + Vector2(-1, 0):
			dir = "northwest"
		elif path[0] == self_cell + Vector2(0, -1):
			dir = "northeast"
		elif path[0] == self_cell + Vector2(1, 0):
			dir = "southeast"
		elif path[0] == self_cell + Vector2(0, 1):
			dir = "southwest"
		
		$AnimatedSprite.play("walk_" + dir)
		
		if position.distance_to(target_position) < 3.0:
			path.remove(0)
		
	else:
		$AnimatedSprite.play("idle_" + dir)
		
		if goal:
			match(goal):
				Game.mobileChart:
					Game.ui.call_deferred("add_child", load("res://computerScreen.tscn").instance())
				Game.jake:
					Events.event_6()
					Game.ui.call_deferred("add_child", load("res://jakeInteraction.tscn").instance())
					
			
			goal = null

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var self_cell = tileMap.world_to_map(position)
		var target_cell = tileMap.world_to_map(get_global_mouse_position())
		
		if target_cell in tileMap.walkable_cells:
			path = tileMap.calculate_path(self_cell, target_cell)
