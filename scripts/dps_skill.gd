extends Skill

@onready var dot_timer = $DoT_timer
var one_shot = false

func _ready():
	damage = 5
	super._ready()

func skill_effect():
	if not one_shot:
		dot_timer.start()
		one_shot = true

func _on_do_t_timer_timeout():
	dps_skill_effect()
	

func dps_skill_effect():
	for enemy in enemy_in_area:
		enemy.on_hit(damage)

