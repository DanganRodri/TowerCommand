extends Control

class_name UpgradeTree

func set_effect(upgrade : UpgradeNode):
	var effect = upgrade.effect_id
	match(effect):
		UpgradeNode.Effect.AtkDps:
			upgrade.effect = atk_dps
			upgrade.description = "Slightly increases the attack of the turret."
		UpgradeNode.Effect.AtkSpeedDps:
			upgrade.effect = atk_speed_dps
			upgrade.description = "Slightly increases the attack speed of the turret."
		UpgradeNode.Effect.Poison:
			upgrade.effect = poison_dps
			upgrade.description = "Transforms all dps turrets into poison dps turrets that deal extra damage over time." + "\n\n" + "Base stats increased." + "\n\n" + "(All the dps turrets builded for the rest of the game will be poison dps turrets)"
		UpgradeNode.Effect.IncreasePoison:
			upgrade.effect = increase_poison
			upgrade.description = "Increases the poison staks damage."
		UpgradeNode.Effect.Weaken:
			upgrade.effect = weaken
			upgrade.description = "Enemies poisoned are weakened, increasing the damage they take from turrets."
		UpgradeNode.Effect.DoubleDps:
			upgrade.effect = double_dps
			upgrade.description = "Transforms all dps turrets into double dps turrets that deal damage up to two targets. (If there is only one target it will take twice as damage)" + "\n\n" + "Base stats increased." + "\n\n" + "(All the dps turrets builded for the rest of the game will be double dps turrets)"
		UpgradeNode.Effect.DpsSkill:
			upgrade.effect = dps_skill
			upgrade.description = "Unlocks the tower skill." + "\n\n" + "Creates an area on the designated location where will be damaged over time."
		UpgradeNode.Effect.DefPenDps:
			upgrade.effect = def_pen_dps
			upgrade.description = "Slightly increases the defense penetration of the turret."
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
			upgrade.description = "Advanced ice turrets throw a freezing wave that makes enemies unable to move for a brief period of time."
		UpgradeNode.Effect.DpsIce:
			upgrade.effect = dps_ice
			upgrade.description = "Transforms all ice turrets into dps ice turrets that heavily increases attack speed and damage." + "\n\n" + "Base stats increased." + "\n\n" + "(All the ice turrets builded for the rest of the game will be dps ice turrets)"
		UpgradeNode.Effect.IceSkill:
			upgrade.effect = ice_skill
			upgrade.description = "Unlocks the tower skill." + "\n\n" + "Creates an area on the designated location where enemies will be slowed and damaged over time."
		UpgradeNode.Effect.RangeIce:
			upgrade.effect = add_range_ice
			upgrade.description = "Slightly increases the effective range of the turret."
		UpgradeNode.Effect.AddDpsIce:
			upgrade.effect = increase_dps_ice
			upgrade.description = "Slightly increases the attack speed and attack of the turret."
		UpgradeNode.Effect.WIP:
			upgrade.effect = wip
			upgrade.description = "WIP."
		UpgradeNode.Effect.AtkAoe:
			upgrade.effect = atk_aoe
			upgrade.description = "Slightly increases the attack of the turret."
		UpgradeNode.Effect.AtkSpeedAoe:
			upgrade.effect = atk_speed_aoe
			upgrade.description = "Slightly increases the attack speed of the turret."
		UpgradeNode.Effect.AdvancedAoe:
			upgrade.effect = advanced_aoe
			upgrade.description = "Transforms all aoe turrets into advanced aoe turrets that deal damage to all enemies within range." + "\n\n" + "Base stats increased." + "\n\n" + "(All the aoe turrets builded for the rest of the game will be advanced aoe turrets)"
		UpgradeNode.Effect.Burn:
			upgrade.effect = burn
			upgrade.description = "Advanced aoe turrets throw a burning wave that deals damage and burns enemies, taking damage over time."
		UpgradeNode.Effect.RangeAoe:
			upgrade.effect = add_range_aoe
			upgrade.description = "Slightly increases the effective range of the turret."
		UpgradeNode.Effect.BurningAoe:
			upgrade.effect = burning_aoe
			upgrade.description = "Transforms all aoe turrets into burning aoe turrets that burns enemies on hit, causing damage to them over time." + "\n\n" + "Base stats increased." + "\n\n" + "(All the aoe turrets builded for the rest of the game will be burning aoe turrets)"
		UpgradeNode.Effect.AoeSkill:
			upgrade.effect = aoe_skill
			upgrade.description = "Unlocks the tower skill." + "\n\n" + "Deals damage and burns enemies in a big area."
		UpgradeNode.Effect.BurnUpgrade:
			upgrade.effect = burn_upgrade
			upgrade.description = "Increases burn damage."
		UpgradeNode.Effect.DefPenSniper:
			upgrade.effect = def_pen_sniper
			upgrade.description = "Slightly increases the defense penetration of the turret."
		UpgradeNode.Effect.AtkSniper:
			upgrade.effect = atk_sniper
			upgrade.description = "Slightly increases the attack of the turret."
		UpgradeNode.Effect.PlasmaSniper:
			upgrade.effect = plasma_sniper
			upgrade.description = "Transforms all sniper turrets into plasma sniper turrets that shots plasma bullets, dealing damage to nearby enemies when impact ." + "\n\n" + "Base stats increased." + "\n\n" + "(All the sniper turrets builded for the rest of the game will be plama sniper turrets)"
		UpgradeNode.Effect.ChargedSniper:
			upgrade.effect = charged_sniper
			upgrade.description = "Every third attack will be a charged attack that deals double true damage"
		UpgradeNode.Effect.AtkSpeedSniper:
			upgrade.effect = atk_speed_sniper
			upgrade.description = "Slightly increases the attack speed of the turret."
		UpgradeNode.Effect.GlobalSniper:
			upgrade.effect = global_sniper
			upgrade.description = "Transforms all sniper turrets into global sniper turrets that has infinite range, its bullets pierces through enemies dealing damage each enemy on impact ." + "\n\n" + "Base stats increased." + "\n\n" + "(All the sniper turrets builded for the rest of the game will be global sniper turrets)"
		UpgradeNode.Effect.SniperSkill:
			upgrade.effect = sniper_skill
			upgrade.description = "Unlocks the tower skill." + "\n\n" + "Deals A LOT of damage in a small area."
		UpgradeNode.Effect.BulletSize:
			upgrade.effect = bullet_size
			upgrade.description = "Increses the size of the bullets and slightly their damage."
		UpgradeNode.Effect.PlayerGold:
			upgrade.effect = player_gold
			upgrade.description = "Increses the gold obtained by a small amount."
		UpgradeNode.Effect.PlayerTurretDiscount:
			upgrade.effect = player_turret_discount
			upgrade.description = "Reduces the cost of leveling turrets."
		UpgradeNode.Effect.PlayerUpgradeDiscount:
			upgrade.effect = player_upgrade_discount
			upgrade.description = "Reduces the cost of turret upgrades in the upgrade tree."
		UpgradeNode.Effect.PlayerLvlUp:
			upgrade.effect = player_lvl_up
			upgrade.description = "Increases players damage and defense penetration."
		
###	DPS UPGRADES /---------------------------------------------------------------------------------------------/

func atk_dps(_upgrade):
	GameData.stat_bonus["atk_dps"] += 0.1

func atk_speed_dps(_upgrade):
	GameData.stat_bonus["atk_speed_dps"] += 0.1

func poison_dps(_upgrade):
	var dps_turrets = get_tree().get_nodes_in_group("dps")
	for dps_turret in dps_turrets:
		create_advanced_turret("res://entities/poison_dps_turret.tscn", dps_turret)
	GameData.advanced_turrets["dps"] = true

func increase_poison(_upgrade):
	if _upgrade.level == 2:
		_upgrade.description = "The turret attacks now splashes the poison to nearby enemies."
		_upgrade.desc.text = _upgrade.description
	if _upgrade.level == 3:
		var dps_turrets = get_tree().get_nodes_in_group("dps")
		for dps_turret in dps_turrets:
			dps_turret.splash = true
		GameData.stat_bonus["poison_splash"] += 1
		return
	GameData.stat_bonus["poison_dot"] += 1

func double_dps(_upgrade):
	var dps_turrets = get_tree().get_nodes_in_group("dps")
	for dps_turret in dps_turrets:
		create_advanced_turret("res://entities/double_dps_turret.tscn", dps_turret)
	GameData.advanced_turrets["double_dps"] = true

func dps_skill(_upgrade):
	var dps_turrets = get_tree().get_nodes_in_group("dps")
	
	if _upgrade.level == 1:
		for dps_turret in dps_turrets:
			var dps_skill = dps_turret.get_node("Skill/Skill")
			dps_skill.show()
			dps_skill.global_position = dps_turret.position + GameData.SKILL_OFFSET
		GameData.active_skills["dps"] = true
		_upgrade.description = "Reduces the skill cooldown."
		_upgrade.desc.text = _upgrade.description
	else:
		for dps_turret in dps_turrets:
			dps_turret.skill.cd -= 5

func def_pen_dps(_upgrade):
	GameData.stat_bonus["def_pen_dps"] += 0.1

func weaken(_upgrade):
	GameData.stat_bonus["weakened_value"] += 0.1
	
###	ICE UPGRADES /---------------------------------------------------------------------------------------------/

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
			
		_upgrade.description = "Reduces the cooldown between freeze waves."
		_upgrade.desc.text = _upgrade.description
		GameData.pasive_skills["freeze"] = true
	
	else:
		GameData.stat_bonus["freeze_cd"] += 0.1
		for ice_turret in ice_turrets:
			ice_turret.freeze_timer.wait_time = GameData.BASE_FREEZE_COOLDOWN / GameData.stat_bonus["freeze_cd"]
			ice_turret.freeze_wave = true
			ice_turret.freeze_timer.start()

func dps_ice(_upgrade):
	var ice_turrets = get_tree().get_nodes_in_group("ice")
	for ice_turret in ice_turrets:
		create_advanced_turret("res://entities/dps_ice_turret.tscn", ice_turret)
	GameData.advanced_turrets["dps_ice"] = true
	
func ice_skill(_upgrade):
	var ice_turrets = get_tree().get_nodes_in_group("ice")
	
	if _upgrade.level == 1:
		for ice_turret in ice_turrets:
			var ice_skill = ice_turret.get_node("Skill/Skill")
			ice_skill.show()
			ice_skill.global_position = ice_turret.position + GameData.SKILL_OFFSET
		GameData.active_skills["ice"] = true
		_upgrade.description = "Reduces the skill cooldown."
		_upgrade.desc.text = _upgrade.description
	else:
		for ice_turret in ice_turrets:
			ice_turret.skill.cd -= 5

func add_range_ice(_upgrade):
	GameData.stat_bonus["range_ice"] += 0.05
	
func increase_dps_ice(_upgrade):
	GameData.stat_bonus["atk_ice"] += 0.1
	GameData.stat_bonus["atk_speed_ice"] += 0.2

###	AOE UPGRADES /---------------------------------------------------------------------------------------------/

func atk_aoe(_upgrade):
	GameData.stat_bonus["atk_aoe"] += 0.1

func atk_speed_aoe(_upgrade):
	GameData.stat_bonus["atk_speed_aoe"] += 0.1

func advanced_aoe(_upgrade):
	var aoe_turrets = get_tree().get_nodes_in_group("aoe")
	for aoe_turret in aoe_turrets:
		create_advanced_turret("res://entities/advanced_aoe_turret.tscn", aoe_turret)
	GameData.advanced_turrets["aoe"] = true

func add_range_aoe(_upgrade):
	GameData.stat_bonus["range_aoe"] += 0.05

func burn(_upgrade):
	var aoe_turrets = get_tree().get_nodes_in_group("aoe")
	
	if _upgrade.level == 1:
		for aoe_turret in aoe_turrets:
			var burn_timer = Timer.new()
			burn_timer.wait_time = GameData.BASE_BURN_COOLDOWN
			burn_timer.one_shot = true
			burn_timer.connect("timeout", Callable(aoe_turret, "_on_burn_timer"))
			aoe_turret.add_child(burn_timer)
			aoe_turret.burn_timer = burn_timer
			aoe_turret.burn_wave = true
			burn_timer.start()
			
		_upgrade.description = "Reduces the cooldown between burn waves and increases burn damage."
		_upgrade.desc.text = _upgrade.description
		GameData.pasive_skills["burn"] = true
	
	else:
		GameData.stat_bonus["burn_cd"] += 0.05
		GameData.stat_bonus["burn_damage"] += 1
		for aoe_turret in aoe_turrets:
			aoe_turret.burn_timer.wait_time = GameData.BASE_BURN_COOLDOWN / GameData.stat_bonus["burn_cd"]
			aoe_turret.burn_wave = true
			aoe_turret.burn_timer.start()

func burning_aoe(_upgrade):
	var aoe_turrets = get_tree().get_nodes_in_group("aoe")
	for aoe_turret in aoe_turrets:
		create_advanced_turret("res://entities/burning_aoe_turret.tscn", aoe_turret)
	GameData.advanced_turrets["burning_aoe"] = true

func aoe_skill(_upgrade):
	var aoe_turrets = get_tree().get_nodes_in_group("aoe")
	
	if _upgrade.level == 1:
		for aoe_turret in aoe_turrets:
			var aoe_skill = aoe_turret.get_node("Skill/Skill")
			aoe_skill.show()
			aoe_skill.global_position = aoe_turret.position + GameData.SKILL_OFFSET
		GameData.active_skills["aoe"] = true
		_upgrade.description = "Reduces the skill cooldown."
		_upgrade.desc.text = _upgrade.description
	else:
		for aoe_turret in aoe_turrets:
			aoe_turret.skill.cd -= 5

func burn_upgrade(_upgrade):
	GameData.stat_bonus["burn_damage"] += 1.5

###	SNIPER UPGRADES /---------------------------------------------------------------------------------------------/

func def_pen_sniper(_upgrade):
	GameData.stat_bonus["def_pen_sniper"] += 0.1

func atk_sniper(_upgrade):
	GameData.stat_bonus["atk_sniper"] += 0.1

func plasma_sniper(_upgrade):
	var sniper_turrets = get_tree().get_nodes_in_group("sniper")
	for sniper_turret in sniper_turrets:
		create_advanced_turret("res://entities/plasma_sniper_turret.tscn", sniper_turret)
	GameData.advanced_turrets["sniper"] = true

func charged_sniper(_upgrade):
	if _upgrade.level == 1:
		GameData.pasive_skills["charged_sniper"] = true
		_upgrade.description = "Increases de explosion radius of charged shots."
		_upgrade.desc.text = _upgrade.description
	if _upgrade.level == 2:
		GameData.pasive_skills["explosion_radius_upgrade"] = true
		_upgrade.description = "Charged shots stun enemies,making them unable to move for a brief period of time and turning off their abilities."
		_upgrade.desc.text = _upgrade.description
	if _upgrade.level == 3:
		GameData.pasive_skills["stun_upgrade"] = true
		

func atk_speed_sniper(_upgrade):
	GameData.stat_bonus["atk_speed_sniper"] += 0.2
	GameData.stat_bonus["atk_sniper"] += 0.05


func global_sniper(_upgrade):
	var sniper_turrets = get_tree().get_nodes_in_group("sniper")
	for sniper_turret in sniper_turrets:
		create_advanced_turret("res://entities/global_sniper_turret.tscn", sniper_turret)
	GameData.advanced_turrets["global_sniper"] = true

func sniper_skill(_upgrade):
	var sniper_turrets = get_tree().get_nodes_in_group("sniper")
	
	if _upgrade.level == 1:
		for sniper_turret in sniper_turrets:
			var sniper_skill = sniper_turret.get_node("Skill/Skill")
			sniper_skill.show()
			sniper_skill.global_position = sniper_turret.position + GameData.SKILL_OFFSET
		GameData.active_skills["sniper"] = true
		_upgrade.description = "Reduces the skill cooldown."
		_upgrade.desc.text = _upgrade.description
	else:
		for sniper_turret in sniper_turrets:
			sniper_turret.skill.cd -= 5

func bullet_size(_upgrade):
	GameData.stat_bonus["bullet_size"] += 0.5

###	Player UPGRADES /---------------------------------------------------------------------------------------------/

func player_gold(_upgrade):
	GameData.stat_bonus["gold_gain"] += 0.075

func player_turret_discount(_upgrade):
	GameData.stat_bonus["turret_discount"] -= 0.15

func player_upgrade_discount(_upgrade):
	GameData.stat_bonus["upgrade_discount"] -= 0.15

func player_lvl_up(_upgrade):
	GameData.stat_bonus["player_bonuses"] += 0.025

###	OTHER STUFF /---------------------------------------------------------------------------------------------/
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
