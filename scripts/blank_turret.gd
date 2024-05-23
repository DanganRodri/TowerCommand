extends Turret

class_name BlankTurret

func _on_dps_pressed():
	create_turret("res://entities/dps_turret.tscn")

func _on_aoe_pressed():
	create_turret("res://entities/aoe_turret.tscn")


func _on_ice_pressed():
	create_turret("res://entities/ice_turret.tscn")


func _on_sniper_pressed():
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
