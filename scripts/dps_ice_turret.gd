extends Turret

class_name DpsIceTurret

@onready var skill = $Skill/Skill

func _ready():
	atk = 12 * GameData.stat_bonus["atk_ice"]
	atk_speed = 0.7 / GameData.stat_bonus["atk_speed_ice"]
	def_pen = 7
	range = 175.0
	attack_frame = 4
	super._ready()

func apply_attack():
	reloading = true
	target.on_hit(atk)
	target.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
	reload_timer.start()

func _on_skill_pressed():
	var ice_skill = load("res://entities/ice_skill.tscn").instantiate()
	skill.add_child(ice_skill)
	ice_skill.global_position = self.position
