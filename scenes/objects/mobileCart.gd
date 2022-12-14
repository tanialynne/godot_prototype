extends Area2D
class_name Interactable

func _ready():
	Game.mobileChart = self
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")
	connect("input_event", self, "on_input_event")

func on_mouse_entered():
	get_node("Sprite") .self_modulate = Color.green

func on_mouse_exited():
	get_node("Sprite").self_modulate = Color.white

func on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		#If in surounding cells...
		var characterPosition = Game.tileMap.world_to_map(Game.character.position)
		var selfCell = Game.tileMap.world_to_map(position)
		
		var surroundingCells : Array
		
		for cell in [
			selfCell + Vector2(-1, 0),
			selfCell + Vector2(0, -1),
			selfCell + Vector2(1, 0),
			selfCell + Vector2(0, 1)
		]:
			if Game.tileMap.get_cellv(cell) in Game.tileMap.walkable_cells_ID:
				surroundingCells.append(cell)
		
		var characterCell = Game.tileMap.world_to_map(Game.character.position)
		
		if characterCell in surroundingCells:
			Game.character.goal = self
			return
		
		var shortestPath : Array
		
		for cell in surroundingCells:
			var path = Game.tileMap.calculate_path(characterPosition, cell)
			
			if path:
				if not shortestPath:
					shortestPath = path
				else:
					if path.size() < shortestPath.size():
						shortestPath = path
		
		if shortestPath:
			Game.character.path = shortestPath
			Game.character.goal = self
