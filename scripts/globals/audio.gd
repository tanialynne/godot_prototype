extends Node

func instance_sound(pos):
	var sound
	
	if pos:
		sound = AudioStreamPlayer2D.new()
		sound.position = pos
	else:
		sound = AudioStreamPlayer.new()
	
	sound.set_stream(load("res://audio/placeholder_sound.ogg"))
	get_viewport().call_deferred("add_child", sound)
	sound.name = "Test Sound"
	sound.play()
	sound.connect("finished", self, "on_sound_finished", [sound])
	sound.connect("tree_exited", self, "on_sound_tree_exited", [sound])

func on_sound_finished(sound):
	sound.call_deferred("free")

func on_sound_tree_exited(sound):
	print(sound.name + " removed!")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		instance_sound(null)
