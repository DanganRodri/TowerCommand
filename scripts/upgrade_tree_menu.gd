extends Panel

var turrets = null

func _on_exit_pressed():
	self.hide()


func _on_open_upgrade_menu_pressed():
	get_tree().paused = true
	turrets = get_tree().root.get_node("Game").get_node("Turrets")
	self.show()

func _input(event):
	if event is InputEventKey and event.is_action_pressed("esc"):
		_on_exit_pressed()
