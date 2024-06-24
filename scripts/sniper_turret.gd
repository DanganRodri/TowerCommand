extends Turret

class_name SniperTurret

func _ready():
	atk = 15
	atk_speed = 2
	def_pen = 25.0
	range = 190.0
	attack_frame = 7
	super._ready()

func apply_attack():
	reloading = true
	target.on_hit(atk, def_pen)
	reload_timer.start()
