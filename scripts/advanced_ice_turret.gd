extends Turret

class_name AdvancedIceTurret

func _ready():
	atk = 6
	atk_speed = 1.8
	def_pen = 0
	range = 155.0
	super._ready()


func fire():
	reloading = true
	for enemy in enemy_in_sight:
		enemy.on_hit(atk)
		enemy.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
	await get_tree().create_timer(atk_speed).timeout
	reloading = false

func _physics_process(delta):
	if not reloading:
		fire()
