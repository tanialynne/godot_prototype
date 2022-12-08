extends Camera2D

func _ready():
	current = true
	smoothing_enabled = true

func _unhandled_input(event):
	if event is InputEventMouseButton:
		match(event.button_index):
			BUTTON_WHEEL_DOWN:
				if zoom < Vector2(1.0, 1.0):
					zoom += Vector2(0.1, 0.1)
			BUTTON_WHEEL_UP:
				if zoom > Vector2(0.3, 0.3):
					zoom -= Vector2(0.1, 0.1)
		
