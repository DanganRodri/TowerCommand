extends Control

class_name UpgradeTree

func set_effect(upgrade : UpgradeNode):
	var effect = upgrade.effect_id
	match(effect):
		UpgradeNode.Effect.AddRange:
			upgrade.effect = add_range
			upgrade.description = "Slightly increases the effective range of the turret."
		UpgradeNode.Effect.AtkSpeed:
			upgrade.effect = add_atkspeed
			upgrade.description = "Slightly increases the attack speed of the turret."
		UpgradeNode.Effect.Dmg:
			upgrade.effect = add_damage
			upgrade.description = "Slightly increases the attack of the turret."
		UpgradeNode.Effect.Slow:
			upgrade.effect = add_slow
			upgrade.description = "Slightly increases the slow effect of the turret."
		UpgradeNode.Effect.SlowDuration:
			upgrade.effect = add_slow_duration
			upgrade.description = "Slightly increases the duration of the slow effect of the turret."
		UpgradeNode.Effect.AdvancedIce:
			upgrade.effect = advanced_ice
			upgrade.description = "Advanced ice."



func add_range():
	print("rango incrementado")

func add_atkspeed():
	print("velocidad de ataque incrementado")

func add_damage():
	print("daño incrementado")

func add_slow():
	GameData.stat_bonus["slow"] += 0.3

func add_slow_duration():
	GameData.stat_bonus["slow_duration"] += 0.11

func advanced_ice():
	var ice_turrets = get_tree().get_nodes_in_group("ice")
	for ice_turret in ice_turrets:
		create_advanced_turret("res://entities/advanced_ice_turret.tscn", ice_turret)
	GameData.advanced_turrets["ice"] = true
	
func create_advanced_turret(turret_path : String, turret_to_advance : Turret):
	
	var new_turret = load(turret_path).instantiate()
	var turrets = get_parent().turrets
	turrets.add_child(new_turret)
	new_turret.global_position = turret_to_advance.global_position
	new_turret.level = turret_to_advance.level
	
	new_turret.total_cost = turret_to_advance.total_cost
	new_turret.cost = turret_to_advance.cost
	
	for i in new_turret.level:
		new_turret.atk = new_turret.atk + (new_turret.atk * 0.2)
		new_turret.atk_speed = new_turret.atk_speed - (new_turret.atk_speed * 0.05)
		new_turret.def_pen = new_turret.def_pen + (new_turret.def_pen * 0.2)
		new_turret.range = new_turret.range + (new_turret.range * 0.025)

	new_turret.get_node("Range/CollisionShape2D").get_shape().radius = new_turret.range

	turret_to_advance.queue_free()
