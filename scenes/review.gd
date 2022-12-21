extends Control

var correctAnswer : bool
var variation : int

var reviews = {
	0 : (
		"“Not a great response. You failed to pick up on the fact that Jake was double-scanning the items, which is the likely the root cause of the errors."\
		+ "\n\nYou lose points for not Listening or giving good feedback.”"
	),
	1 : (
		"“You recognised that Jake wasn’t doing things properly, but you failed to control your anger about the situation. Also, you didn’t explain the correct process, which would likely just create more errors."\
		+ "\n\nYou lose points for not adapting to the situation, providing clarity or giving constructive feedback.”"
	),
	2 : (
		"“You failed to pick up on the fact that Jake wasn’t carrying out the process correctly and in fact made it worse."\
		+ "\n\nYou lose points for giving poor feedback.”"
	),
	3 : (
		"“Five stars! You coached Jake by letting him know what he was doing wrong, why it’s wrong, and how to correct the process."\
		+"\n\nYou gain points for great clarity and giving constructive feedback.”"
	)
}

func _ready():
	if correctAnswer:
		$icon.set_texture(load("res://textures/interaction/thumbs_up.png"))
	else:
		$icon.set_texture(load("res://textures/interaction/thumbs_down.png"))
	
	$buttonReturn.connect("pressed", self, "on_buttonReturn_connect")
	$RichTextLabel.push_bold()
	$RichTextLabel.add_text("Amazon Review: ")
	$RichTextLabel.push_normal()
	$RichTextLabel.add_text(reviews[variation])
	
	Game.jake.get_node("speechBubble").call_deferred("free")
	var speechBubble = load("res://scenes/speechBubble.tscn").instance()
	Game.jake.call_deferred("add_child", speechBubble)
	speechBubble.variation = variation + 5
	speechBubble.rect_position += Vector2(128, -320)
	
	var speechBubble_0 = load("res://scenes/speechBubble.tscn").instance()
	speechBubble_0.left = true
	Game.character.call_deferred("add_child", speechBubble_0)
	speechBubble_0.variation = variation
	speechBubble_0.rect_position += Vector2(-392, -320)

func on_buttonReturn_connect():
	Game.character.get_node("speechBubble").call_deferred("free")
	Game.jake.get_node("speechBubble").call_deferred("free")
	Game.jake.get_node("focusHighlight").call_deferred("free")
	call_deferred("free")
