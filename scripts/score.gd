extends Label

func _process(delta):
	self.text= str( roundi(GameData.score * (1 + (GameData.score_increase * 0.11))) ) 
