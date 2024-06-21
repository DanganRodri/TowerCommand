extends Turret

class_name DpsTurret

func _ready():
	atk = 10 * GameData.stat_bonus["atk_dps"]
	atk_speed = 0.75 / GameData.stat_bonus["atk_speed_dps"]
	def_pen = 7
	range = 170.0
	attack_frame = 4
	super._ready()

