extends Turret

class_name BlankTurret


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var upgradeList = get_node("Upgrade/UpgradeList")
		upgradeList.visible = !upgradeList.visible
		
		upgradeList.global_position = self.position + Vector2(-115, 28)


func _on_dps_pressed():
	create_turret("res://entities/dps_turret.tscn")

func _on_aoe_pressed():
	create_turret("res://entities/aoe_turret.tscn")


func _on_ice_pressed():
	create_turret("res://entities/ice_turret.tscn")


func _on_sniper_pressed():
	create_turret("res://entities/sniper_turret.tscn")

func create_turret(turret_path):
	var new_turret = load(turret_path).instantiate()
	var root_node = get_parent().get_parent()
	root_node.get_node("Turrets").add_child(new_turret)
	new_turret.global_position = global_position
	queue_free()
