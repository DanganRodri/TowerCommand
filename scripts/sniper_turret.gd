extends Turret

class_name SniperTurret

var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 15
	atk_speed = 2
	def_pen = 25.0
	range = 190.0
	attack_frame = 7
	super._ready()

func apply_attack():
	reloading = true
	var new_bullet : Bullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk  * GameData.stat_bonus["atk_sniper"]
	new_bullet.def_pen = def_pen * GameData.stat_bonus["def_pen_sniper"]
	#target.on_hit(atk, def_pen)
	reload_timer.start()
