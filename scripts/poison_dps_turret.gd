extends Turret

class_name PoisonDpsTurret

var splash : bool = false
var explosion_radius : float = 50.0

func _ready():
	atk = 11
	atk_speed = 0.725 
	def_pen = 9
	range = 175.0
	attack_frame = 4
	splash = GameData.poison_splash
	super._ready()


func apply_attack():
	reloading = true
	target.on_hit(atk * GameData.stat_bonus["atk_dps"] , def_pen)
	if splash:
		area_hit()
	else:
		target.status_effect("poison", GameData.BASE_POISON_DURATION , GameData.BASE_POISON)
		target.status_effect("weaken", GameData.BASE_POISON_DURATION , GameData.BASE_POISON)
	reload_timer.start()

func area_hit():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var shape = CircleShape2D.new()
	shape.radius = explosion_radius
	query.shape = shape
	query.transform.origin = target.position

	var result = space_state.intersect_shape(query)
	
	for enemy in result:
		if enemy.collider and enemy.collider.is_in_group("enemy"):
			enemy.collider.status_effect("poison", GameData.BASE_POISON_DURATION , GameData.BASE_POISON)
			target.status_effect("weaken", GameData.BASE_POISON_DURATION , GameData.BASE_POISON)
