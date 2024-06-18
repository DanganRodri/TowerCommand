extends Skill

@onready var dot_timer = $DoT_timer
var one_shot = false


func skill_effect():
	if not one_shot:
		dot_timer.start()
		one_shot = true

func _on_do_t_timer_timeout():
	ice_skill_effect()
	

func ice_skill_effect():
	for enemy in enemy_in_area:
		enemy.on_hit(damage)
		enemy.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)

