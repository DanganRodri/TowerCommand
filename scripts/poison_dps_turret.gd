extends Turret

class_name PoisonDpsTurret

func _ready():
	atk = 11
	atk_speed = 0.725
	def_pen = 9
	range = 175.0
	attack_frame = 4
	super._ready()


func apply_attack():
	reloading = true
	target.on_hit(atk)
	target.status_effect("poison", GameData.BASE_POISON_DURATION , GameData.BASE_POISON)
	reload_timer.start()
