extends Turret

class_name BlankTurret

@onready var ice : Button = $Upgrade/UpgradeList/HBoxContainer/Ice
@onready var dps = $Upgrade/UpgradeList/HBoxContainer/Dps
@onready var aoe = $Upgrade/UpgradeList/HBoxContainer/Aoe
@onready var sniper = $Upgrade/UpgradeList/HBoxContainer/Sniper


func _process(delta):
	if GameData.advanced_turrets["dps"]:
		dps.icon = load("res://assets/sprites/poison_dps_turret.png")
	if GameData.advanced_turrets["double_dps"]:
		dps.icon = load("res://assets/sprites/double_dps_turret.png")
	if GameData.advanced_turrets["ice"]:
		ice.icon = load("res://assets/sprites/advanced_ice_turret.png")
	if GameData.advanced_turrets["dps_ice"]:
		ice.icon = load("res://assets/sprites/dps_ice_turret.png")
	if GameData.advanced_turrets["aoe"]:
		aoe.icon = load("res://assets/sprites/advanced_aoe_turret.png")
	if GameData.advanced_turrets["burning_aoe"]:
		aoe.icon = load("res://assets/sprites/burning_aoe_turret.png")
	if GameData.advanced_turrets["sniper"]:
		sniper.icon = load("res://assets/sprites/plasma_turret.png")
	if GameData.advanced_turrets["global_sniper"]:
		sniper.icon = load("res://assets/sprites/global_sniper_turret.png")
	
	super._process(delta)
		
func _on_dps_pressed():
	
	if GameData.advanced_turrets["dps"]:
		create_turret("res://entities/poison_dps_turret.tscn")
	elif GameData.advanced_turrets["double_dps"]:
		create_turret("res://entities/double_dps_turret.tscn")
	else:	
		create_turret("res://entities/dps_turret.tscn")

func _on_aoe_pressed():
	if GameData.advanced_turrets["aoe"]:
		create_turret("res://entities/advanced_aoe_turret.tscn")
	elif GameData.advanced_turrets["burning_aoe"]:
		create_turret("res://entities/burning_aoe_turret.tscn")
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
		create_turret("res://entities/plasma_sniper_turret.tscn")
	elif GameData.advanced_turrets["global_sniper"]:
		create_turret("res://entities/global_sniper_turret.tscn")
	else:
		create_turret("res://entities/sniper_turret.tscn")

func create_turret(turret_path):
	if GameData.gold >= self.cost:
		GameData.gold -= self.cost
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
	
	if turret.is_in_group("aoe") and GameData.pasive_skills["burn"]:
		var burn_timer = Timer.new()
		burn_timer.wait_time = GameData.BASE_BURN_COOLDOWN * GameData.stat_bonus["burn_cd"]
		burn_timer.one_shot = true
		burn_timer.connect("timeout", Callable(turret, "_on_burn_timer"))
		turret.add_child(burn_timer)
		turret.burn_timer = burn_timer
		turret.burn_wave = true
		burn_timer.start()

func check_active_skills(turret):
	if turret.is_in_group("ice") and GameData.active_skills["ice"]:
		var skill = turret.get_node("Skill/Skill")
		skill.global_position = turret.position + GameData.SKILL_OFFSET
		skill.show()
	if turret.is_in_group("dps") and GameData.active_skills["dps"]:
		var skill = turret.get_node("Skill/Skill")
		skill.global_position = turret.position + GameData.SKILL_OFFSET
		skill.show()
