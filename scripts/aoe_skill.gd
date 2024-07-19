extends Skill

var one_shot = false

func _ready():
	super._ready()
	collision_shape_2d.shape.radius = 175

func skill_effect():
	if not one_shot:
		aoe_skill_effect()


func aoe_skill_effect():
	one_shot = true
	for enemy in enemy_in_area:
		enemy.on_hit(damage, 100)
		enemy.status_effect("burn", GameData.BASE_BURN_DURATION , 0)

