extends Turret

class_name DoubleDpsTurret

@onready var skill = $Skill/Skill
var second_target : Enemy
var bullet = preload("res://entities/bullet.tscn")

func _ready():
	atk = 12 
	atk_speed = 0.65 
	def_pen = 9 
	range = 180.0
	attack_frame = 4
	super._ready()


func _physics_process(delta):
	if self.stunned:
			return
	if target == null and not enemy_in_sight.is_empty():
		select_enemy()
	if second_target == null:
		select_second_enemy()
	if (target != null or second_target != null) and not reloading:
		if  animated_sprite_2d.animation == "default":
			fire()
		if animated_sprite_2d.animation == "shoot" and animated_sprite_2d.frame == attack_frame:
			apply_attack()

func turn():
	if target != null:
		self.look_at(target.position)
		return
	if second_target != null:
		self.look_at(second_target.position)

func select_enemy():
	target = GlobalFunctions.check_closest_exclusive(defending_tower, second_target,enemy_in_sight)
	
func select_second_enemy():
	
	if enemy_in_sight.size() == 1 and target != null:
		second_target = target
		return
		
	if not enemy_in_sight.is_empty():
		second_target = GlobalFunctions.check_closest_exclusive(defending_tower, target, enemy_in_sight)

func apply_attack():
	reloading = true
	if target != null:
		var new_bullet : Bullet = bullet.instantiate()
		get_node("Bullets").add_child(new_bullet)
		new_bullet.global_position = self.global_position
		new_bullet.target = self.target
		new_bullet.target_pos = self.target.global_position
		new_bullet.atk = atk * GameData.stat_bonus["atk_dps"]
		new_bullet.def_pen = def_pen * GameData.stat_bonus["def_pen_dps"]
		#target.on_hit(atk * GameData.stat_bonus["atk_dps"], def_pen * GameData.stat_bonus["def_pen_dps"])
		
	if second_target != null:
		var new_bullet : Bullet = bullet.instantiate()
		get_node("Bullets").add_child(new_bullet)
		new_bullet.global_position = self.global_position
		new_bullet.target = self.second_target
		new_bullet.target_pos = self.second_target.global_position
		new_bullet.atk = atk * GameData.stat_bonus["atk_dps"]
		new_bullet.def_pen = def_pen * GameData.stat_bonus["def_pen_dps"]
		#second_target.on_hit(atk, def_pen)
	reload_timer.start()

func _on_skill_pressed():
	var ice_skill = load("res://entities/dps_skill.tscn").instantiate()
	skill.add_child(ice_skill)
	ice_skill.global_position = self.position

func _on_range_body_exited(body):
	if body == target:
		enemy_in_sight.erase(target)
		target = null
	if body == second_target:
		enemy_in_sight.erase(second_target)
		second_target = null
		
