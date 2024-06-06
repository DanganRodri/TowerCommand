extends Panel

var turrets = null

func _on_exit_pressed():
	self.hide()


func _on_open_upgrade_menu_pressed():
	turrets = get_tree().root.get_node("Game").get_node("Turrets")
	print(turrets)
	self.show()
