extends Turret

class_name PlasmaSniperTurret

var explosion_radius : float = 50.0
var charge : int = 1
var charge_unlocked : bool = false
var explosion_radius_upgrade = false
var stun_upgrade = false
var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 20
	atk_speed = 1.8
	def_pen = 32.5
	range = 210.0
	attack_frame = 17
	super._ready()


func _physics_process(delta):
	if self.stunned:
			return
	if GameData.pasive_skills["charged_sniper"] == true:
		charge_unlocked = true
	if GameData.pasive_skills["explosion_radius_upgrade"] == true:
		explosion_radius_upgrade = true
	if GameData.pasive_skills["stun_upgrade"] == true:
		stun_upgrade = true
	
	if target == null:
		select_enemy()
	if target != null and not reloading:
		if  animated_sprite_2d.animation == "default":
			fire()
		if (animated_sprite_2d.animation == "shoot" or animated_sprite_2d.animation == "charged_shoot") and animated_sprite_2d.frame == attack_frame:
			apply_attack()
		

func fire():
	turn()
	if charge_unlocked and charge == 3:
		animated_sprite_2d.play("charged_shoot")
		return
	else:
		animated_sprite_2d.play("shoot")
			

func apply_attack():
	reloading = true
	var def_pen_difference = 0
	
	if charge_unlocked and charge == 3:
		self.atk *= 2
		if explosion_radius_upgrade:
			self.explosion_radius += 25.0
		def_pen_difference = 100.0 - self.def_pen
		self.def_pen = 100.0
	
	var new_bullet : Bullet = bullet.instantiate()
	get_node("Bullets").add_child(new_bullet)
	new_bullet.scale *= 1.2
	new_bullet.global_position = self.global_position
	new_bullet.target = self.target
	new_bullet.target_pos = self.target.global_position
	new_bullet.atk = atk * GameData.stat_bonus["atk_sniper"]
	new_bullet.def_pen = def_pen * GameData.stat_bonus["def_pen_sniper"]
	new_bullet.on_area = true
	new_bullet.explosion_radius = explosion_radius
	
	if charge == 3 and stun_upgrade:
		new_bullet.modulate = GameData.COLOR_DATA["STATUS"]["STUN_COLOR"]
		new_bullet.scale *= 2
		new_bullet.status_effect = "stun"
		new_bullet.status_duration = GameData.BASE_STUN_DURATION
		new_bullet.status_value = 0
	#area_hit()
	
	if charge_unlocked and charge == 3:
		self.atk /= 2
		if explosion_radius_upgrade:
			self.explosion_radius -= 25.0
		self.def_pen -= def_pen_difference
		charge = 1
		reload_timer.start()
		return
		
	if charge_unlocked:
			charge += 1
			
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
			enemy.collider.on_hit(atk * GameData.stat_bonus["atk_sniper"], self.def_pen * GameData.stat_bonus["def_pen_sniper"])
			if charge == 3 and stun_upgrade:
				enemy.collider.status_effect("stun", GameData.BASE_STUN_DURATION , 0)
