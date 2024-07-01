extends Label

var gold = 0

func _ready():
	self.modulate = Color(1, 0.85, 0)

func _process(delta):
	self.gold = GameData.gold
	self.text= str(GameData.gold)
