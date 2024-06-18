extends Turret

class_name BlankTurret

func _on_dps_pressed():
	
	if GameData.advanced_turrets["dps"]:
		create_turret("res://entities/advanced_dps_turret.tscn")
	else:	
		create_turret("res://entities/dps_turret.tscn")

func _on_aoe_pressed():
	if GameData.advanced_turrets["aoe"]:
		create_turret("res://entities/advanced_aoe_turret.tscn")
	else:
		create_turret("res://entities/aoe_turret.tscn")


func _on_ice_pressed():
	if GameData.advanced_turrets["ice"]:
		create_turret("res://entities/advanced_ice_turret.tscn")
	elif GameData.advanced_turrets["dps_ice"]:
		create_turret("res://entities/dps_ice_turret.tscn")
	else:
		create_turret("res://entities/ice_turret.tscn")


func _on_sniper_pressed():
	if GameData.advanced_turrets["sniper"]:
		create_turret("res://entities/advanced_sniper_turret.tscn")
	else:
		create_turret("res://entities/sniper_turret.tscn")

func create_turret(turret_path):
	var root = get_parent().get_parent()
	if root.gold >= self.cost:
		root.gold = root.gold - self.cost
		var new_turret = load(turret_path).instantiate()
		var root_node = get_parent().get_parent()
		root_node.get_node("Turrets").add_child(new_turret)
		new_turret.global_position = global_position
		check_pasive_skills(new_turret)
		check_active_skills(new_turret)
		Engine.set_time_scale(self.last_fastforward_speed)
		queue_free()

func check_pasive_skills(turret):
	if turret.is_in_group("ice") and GameData.pasive_skills["freeze"]:
		var freeze_timer = Timer.new()
		freeze_timer.wait_time = GameData.BASE_FREEZE_COOLDOWN * GameData.stat_bonus["freeze_cd"]
		freeze_timer.one_shot = true
		freeze_timer.connect("timeout", Callable(turret, "_on_freeze_timer"))
		turret.add_child(freeze_timer)
		turret.freeze_timer = freeze_timer
		turret.freeze_wave = true
		freeze_timer.start()

func check_active_skills(turret):
	if turret.is_in_group("ice") and GameData.active_skills["ice"]:
		var skill = turret.get_node("Skill/Skill")
		skill.global_position = turret.position + GameData.SKILL_OFFSET
		skill.show()
