extends Label

var left : bool
var variation : int

var texts = {
	0 : (
		"Yes! Keep up the good work. In fact, I might get"\
		+ "\nUma to shadow you so she can work more quickly."
	),
	1 : (
		"No! You can’t just rapid induct like that! Get it done properly"\
		+ "\nor there’ll be consequences! The correct process is written"\
		+ "\ndown somewhere so find it!"
	),
	2 : (
		"Scanning two labels at a time is a good idea but can you increase"\
		+ "\nit to three? Or even four? The more you scan, the bigger our output."
	),
	3 : (
		"No. You should scan and apply the label on one shipment at a time."\
		+ "\nDouble scanning means shipments could go to the wrong destination."
	),
	4 : (
		"'Hey, " + Game.stringholder_characterName + "." + " I Assume you'v come to congradulate me"
		+ "\non absolutely smashing my goals today! I've just discovered a"
		+ "\nnew technique - I scan and apply the labels for two items at a"
		+ "\ntime before placing them on the belt. Isn't that great?"
	),
	5 : 
		(
		"“Oh, great – although, now I think about it…I wonder"\
		+ "\nif double-scanning might cause issues further down the"\
		+ "line?”"
		),
	6 : (
		"“Oh…sorry, boss. I’ll try and do better next time. Or I would if I"\
		+ "\nknew the correct process. But don’t worry, I’ll"\
		+ "\ntry and find it.”"
	),
	7 : 
		(
		"Er, sure, I suppose. But didn’t you think doubling the"\
		+ "\noutput was good enough? If I work even faster, I’m"\
		+ "\nlikely to make mistakes. Hmm…maybe I’m already"\
		+ "\nmaking mistakes…”"
		),
	8 : 
		(
		"“Oh, that’s great advice, boss! I had no idea. And"\
		+ "\nthanks for explaining it to me so clearly. I’ll single scan"\
		+ "\them from now on to avoid errors.”"
		)
}

func _ready():
	if left:
		$MarginContainer/NinePatchRect.texture = load("res://textures/uma_bubble.png")
	name = "speechBubble"
	set_text(
		texts[variation]
	)
