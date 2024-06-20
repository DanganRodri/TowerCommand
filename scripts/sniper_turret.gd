extends Turret

class_name SniperTurret

func _ready():
	atk = 15
	atk_speed = 2
	def_pen = 3
	range = 190.0
	attack_frame = 7
	super._ready()
