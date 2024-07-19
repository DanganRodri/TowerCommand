extends Turret

class_name GlobalSniperTurret
@onready var skill = $Skill/Skill

var bullet = preload("res://entities/global_sniper_bullet.tscn")

func _draw():
	pass

func _ready():
	atk = 18
	atk_speed = 2
	def_pen = 32.5
	range = 9999.9
	attack_frame = 7
	super._ready()

func apply_attack():
	reloading = true
	AudioHandler.play_SFX("res://SFX/shot.wav")
	var new_bullet : GlobalSniperBullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk  * GameData.stat_bonus["atk_sniper"]
	new_bullet.def_pen = def_pen * GameData.stat_bonus["def_pen_sniper"]
	new_bullet.scale *= GameData.stat_bonus["bullet_size"]
	#target.on_hit(atk, def_pen)
	reload_timer.start()


func _on_skill_pressed():
	var sniper_skill = load("res://entities/sniper_skill.tscn").instantiate()
	sniper_skill.damage = self.atk * 3
	skill.add_child(sniper_skill)
	sniper_skill.global_position = self.position
