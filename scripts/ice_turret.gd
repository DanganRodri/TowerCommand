extends Turret

class_name IceTurret

var explosion_radius : float = 100.0

func _ready():
	atk = 4
	atk_speed = 2
	def_pen = 0
	range = 130.0
	attack_frame = 5
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
			enemy.collider.on_hit(atk)
			enemy.collider.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
