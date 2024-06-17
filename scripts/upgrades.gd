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
			upgrade.description = "Transforms all ice turrets into advanced ice turrets that deal damage to all enemies within range." + "\n\n" + "Base stats increased." + "\n\n" + "(All the ice turrets builded for the rest of the game will be advanced ice turrets)"
		UpgradeNode.Effect.Freeze:
			upgrade.effect = freeze
			upgrade.description = "Advanced ice turrets throw a freezing wave that makes enemies unable to move for a brief period of time." + "\n\n" + "Additional skill point increases the freeze wave frequency."
		UpgradeNode.Effect.DpsIce:
			upgrade.effect = dps_ice
			upgrade.description = "Transforms all ice turrets into dps ice turrets that heavily increases attack speed and damage." + "\n\n" + "Base stats increased." + "\n\n" + "(All the ice turrets builded for the rest of the game will be dps ice turrets)"
		UpgradeNode.Effect.WIP:
			upgrade.effect = wip
			upgrade.description = "WIP."


func add_range(_upgrade):
	GameData.stat_bonus["range"] += 0.10

func add_atkspeed(_upgrade):
	print("velocidad de ataque incrementado")

func add_damage(_upgrade):
	print("daño incrementado")

func add_slow(_upgrade):
	GameData.stat_bonus["slow"] += 0.3

func add_slow_duration(_upgrade):
	GameData.stat_bonus["slow_duration"] += 0.11

func advanced_ice(_upgrade):
	var ice_turrets = get_tree().get_nodes_in_group("ice")
	for ice_turret in ice_turrets:
		create_advanced_turret("res://entities/advanced_ice_turret.tscn", ice_turret)
	GameData.advanced_turrets["ice"] = true
	

func freeze(_upgrade):
	var ice_turrets = get_tree().get_nodes_in_group("ice")
	
	if _upgrade.level == 1:
		for ice_turret in ice_turrets:
			var freeze_timer = Timer.new()
			freeze_timer.wait_time = GameData.BASE_FREEZE_COOLDOWN
			freeze_timer.one_shot = true
			freeze_timer.connect("timeout", Callable(ice_turret, "_on_freeze_timer"))
			ice_turret.add_child(freeze_timer)
			ice_turret.freeze_timer = freeze_timer
			ice_turret.freeze_wave = true
			freeze_timer.start()
		GameData.pasive_skills["freeze"] = true
	
	else:
		GameData.stat_bonus["freeze_cd"] += 0.1
		for ice_turret in ice_turrets:
			ice_turret.freeze_timer.wait_time = GameData.BASE_FREEZE_COOLDOWN * GameData.stat_bonus["freeze_cd"]
			ice_turret.freeze_wave = true
			ice_turret.freeze_timer.start()

func dps_ice(_upgrade):
	var ice_turrets = get_tree().get_nodes_in_group("ice")
	for ice_turret in ice_turrets:
		create_advanced_turret("res://entities/dps_ice_turret.tscn", ice_turret)
	GameData.advanced_turrets["dps_ice"] = true

func wip(_upgrade):
	pass
	
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
