extends Enemy

class_name BasicLord

func _init():
	super._init("BasicLord", 30*GameData.LORD_STAT_BONUS, 1.0*GameData.LORD_STAT_BONUS, 40, 150,false)
	
