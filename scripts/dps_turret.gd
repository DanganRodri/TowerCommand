extends Turret

class_name DpsTurret

func _ready():
	atk = 10 
	atk_speed = 0.75 
	def_pen = 7
	range = 170.0
	attack_frame = 4
	super._ready()
	

func apply_attack():
	reloading = true
	target.on_hit(atk * GameData.stat_bonus["atk_dps"] , self.def_pen)
	reload_timer.start()

