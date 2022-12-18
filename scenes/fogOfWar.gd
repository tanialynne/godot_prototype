extends TextureRect

func _ready():
	pass

func _process(delta):
	return
	if Game.character.path.size() == 0:
		$Tween.interpolate_property(
			self, "self_modulate:a",
			self_modulate.a, 0.0, 1.0,
			Tween.TRANS_SINE, Tween.EASE_IN
		)
		$Tween.start()
	
	else:
		$Tween.interpolate_property(
			self, "self_modulate:a",
			self_modulate, 1.0, 1.0,
			Tween.TRANS_SINE, Tween.EASE_IN
		)
		$Tween.start()
