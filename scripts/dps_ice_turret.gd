extends Turret

class_name DpsIceTurret

@onready var skill = $Skill/Skill
var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 12 
	atk_speed = 0.7
	def_pen = 8.5
	range = 175.0
	attack_frame = 4
	super._ready()

func apply_attack():
	AudioHandler.play_SFX("res://SFX/shot.wav")
	reloading = true
	var new_bullet : Bullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.modulate = GameData.COLOR_DATA["STATUS"]["SLOWED_COLOR"]
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk * GameData.stat_bonus["atk_ice"]
	new_bullet.def_pen = def_pen
	new_bullet.status_effect = "slow"
	new_bullet.status_duration = GameData.BASE_SLOW_DURATION
	new_bullet.status_value = GameData.BASE_SLOW
	#target.on_hit(atk * GameData.stat_bonus["atk_ice"], def_pen)
	#target.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
	reload_timer.start()

func _on_skill_pressed():
	var ice_skill = load("res://entities/ice_skill.tscn").instantiate()
	ice_skill.damage = self.atk * 0.25
	skill.add_child(ice_skill)
	ice_skill.global_position = self.position
