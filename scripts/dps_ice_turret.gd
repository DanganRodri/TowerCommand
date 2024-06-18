extends Turret

class_name DpsIceTurret

var explosion_radius : float = 100.0
@onready var skill = $Skill/Skill

func _ready():
	atk = 12
	atk_speed = 0.7
	def_pen = 7
	range = 175.0
	super._ready()

func fire():
	reloading = true
	target.on_hit(atk)
	target.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
	await get_tree().create_timer(atk_speed).timeout
	reloading = false



func _on_skill_pressed():
	var ice_skill = load("res://entities/ice_skill.tscn").instantiate()
	skill.add_child(ice_skill)
	ice_skill.global_position = self.position
