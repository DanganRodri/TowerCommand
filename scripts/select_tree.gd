extends Panel



func _on_exit_pressed():
	get_parent().hide()


func _on_dps_tree_button_pressed():
	self.hide()
	get_parent().show_tree("dps_upgrade_button")


func _on_ice_tree_button_pressed():
	self.hide()
	get_parent().show_tree("ice_upgrade_button")


func _on_aoe_tree_button_pressed():
	self.hide()
	get_parent().show_tree("aoe_upgrade_button")
