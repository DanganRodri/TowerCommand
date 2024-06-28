extends Turret

class_name AoeTurret

var explosion_radius : float = 50.0
var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 10
	atk_speed = 2
	def_pen = 5.0
	range = 150.0
	attack_frame = 5
	super._ready()


func apply_attack():
	reloading = true
	var new_bullet : Bullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.scale *= 1.3
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk * GameData.stat_bonus["atk_aoe"]
	new_bullet.def_pen = def_pen
	new_bullet.on_area = true
	new_bullet.explosion_radius = explosion_radius
	#area_hit()
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
			enemy.collider.on_hit(atk * GameData.stat_bonus["atk_aoe"], self.def_pen)
	
	
	
