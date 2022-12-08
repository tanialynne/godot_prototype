extends TextureRect

func _ready():
	$label_character.set_text(Game.stringholder_characterName)
	$TextureRect.texture = load(Game.avatar)

func _process(delta):
	pass
