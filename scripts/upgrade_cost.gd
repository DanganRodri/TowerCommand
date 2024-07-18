extends Label

var cost : int = 0

func _process(delta):
	
	if cost > GameData.gold:
		self.modulate = Color(1, 0, 0)
	else:
		self.modulate = Color(1, 1, 1)
	self.text = str( cost )

