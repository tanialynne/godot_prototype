extends TextureRect

func _ready():
	$label_character.set_text(Game.stringholder_characterName)
	$TextureRect.texture = load(Game.avatar)

func _process(delta):
	$textureProgress_adaptability.max_value = Game.character.adaptability_maximum
	$textureProgress_adaptability.value = Game.character.adaptability_current
	
	$textureProgress_adaptability.max_value = Game.character.listening_maximum
	$textureProgress_adaptability.value = Game.character.listening_current
	
	$textureProgress_adaptability.max_value = Game.character.clarity_maximum
	$textureProgress_adaptability.value = Game.character.clarity_current
	
	$textureProgress_adaptability.max_value = Game.character.feedback_maximum
	$textureProgress_adaptability.value = Game.character.feedback_current
