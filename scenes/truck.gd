extends Node2D

export var goal_position : Vector2
export var time : float

func _ready():
	if name == "truck_0":
		Station.truck_0 = self
	else:
		Station.truck_1 = self

func move():
	$Tween.interpolate_property(
		self, "position", position, goal_position,
		time, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	$Tween.start()
