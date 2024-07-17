extends Label

var gold = 0


func _process(delta):
	self.gold = GameData.gold
	self.text= str(GameData.gold)
