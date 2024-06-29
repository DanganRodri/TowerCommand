extends Turret

class_name PoisonDpsTurret

var splash : bool = false
var explosion_radius : float = 50.0
var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 11
	atk_speed = 0.725 
	def_pen = 9
	range = 175.0
	attack_frame = 4
	if GameData.stat_bonus["poison_splash"] > 1:
		splash = true
	else:
		splash = false
	super._ready()


func apply_attack():
	reloading = true
	var new_bullet : Bullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.modulate = GameData.COLOR_DATA["STATUS"]["POISONED_COLOR"]
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk * GameData.stat_bonus["atk_dps"]
	new_bullet.def_pen = def_pen
	new_bullet.status_effect = "poison"
	new_bullet.status_duration = GameData.BASE_POISON_DURATION
	new_bullet.status_value = GameData.BASE_POISON
	
	#target.on_hit(atk * GameData.stat_bonus["atk_dps"] , def_pen)
	if splash:
		new_bullet.on_area = true
		new_bullet.explosion_radius = self.explosion_radius
	
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
