extends Enemy

class_name Stealth

func _init():
	super._init("Stealth", 35, 1.0, 45, 150,false)

func _ready():
	self.stealth = true
	super._ready()
