extends Turret

class_name DpsTurret
var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 10 
	atk_speed = 0.75 
	def_pen = 7
	range = 170.0
	attack_frame = 4
	super._ready()
	

func apply_attack():
	reloading = true
	var new_bullet : Bullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk * GameData.stat_bonus["atk_dps"]
	new_bullet.def_pen = def_pen
	#target.on_hit(atk * GameData.stat_bonus["atk_dps"] , self.def_pen)
	reload_timer.start()

