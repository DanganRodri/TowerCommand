extends Turret

class_name BurningAoeTurret

var explosion_radius : float = 75.0

func _ready():
	atk = 12
	atk_speed = 1.65
	def_pen = 10.0
	range = 160.0
	attack_frame = 7
	super._ready()


func apply_attack():
	reloading = true
	area_hit()
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
			enemy.collider.on_hit(atk * GameData.stat_bonus["aoe_atk"], self.def_pen)
			enemy.collider.status_effect("burn", GameData.BASE_BURN_DURATION , 0)
	
	
	
