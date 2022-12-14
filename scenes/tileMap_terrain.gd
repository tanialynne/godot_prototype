extends TileMap

onready var aStar2D = AStar2D.new()
var walkable_cells : Array
onready var walkable_cells_ID : Array = [0, 1, 2, 3, 4, 5, 6, 7]

func _ready():
	Game.tileMap = self
	add_points()
	connect_points()
	
func add_points():
	for cell in get_used_cells():
		if get_cellv(cell) in walkable_cells_ID:
			walkable_cells.append(cell)
	
	for cell in walkable_cells:
		aStar2D.add_point(id(cell), cell, 1.0)

func connect_points():
	var neighbors = [
		Vector2(-1, 0),
		Vector2(0, -1),
		Vector2(1, 0),
		Vector2(0, 1)
	]
	
	for cell in walkable_cells:
		for neighbor in neighbors:
			var next_cell = cell + neighbor
			if get_cell(next_cell.x, next_cell.y) in walkable_cells_ID:
				aStar2D.connect_points(id(cell), id(next_cell), false)

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b

func calculate_path(start, end):
	var path = aStar2D.get_point_path(id(start), id(end))
	if path:
		path.remove(0)
	return path
	
