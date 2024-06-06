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
		queue_free()
