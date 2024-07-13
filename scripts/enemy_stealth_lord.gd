extends Enemy

class_name StealthLord

func _init():
	super._init("StealthLord", 35*GameData.LORD_STAT_BONUS, 1.0*GameData.LORD_STAT_BONUS, 45, 150,false)

func _ready():
	self.stealth = true
	super._ready()
