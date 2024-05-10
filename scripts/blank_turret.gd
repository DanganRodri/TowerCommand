extends Turret

class_name BlankTurret

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		# Lógica para instanciar la escena en la posición del nodo
		var new_turret = load("res://entities/dps_turret.tscn").instantiate()
		var root_node = get_parent().get_parent()
		root_node.get_node("Turrets").add_child(new_turret)
		new_turret.global_position = global_position
		# Luego de instanciar la escena, elimina este nodo
		queue_free()
