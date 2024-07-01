extends Panel

@onready var ui = $"../.."

func _on_exit_pressed():
	CursorManager.on_menu_exit()
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	ui.on_upgrade_menu = false
	ui.unpause_countdown()
	get_parent().hide()


func _on_dps_tree_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	self.hide()
	get_parent().show_tree("dps_upgrade_button")


func _on_ice_tree_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	self.hide()
	get_parent().show_tree("ice_upgrade_button")


func _on_aoe_tree_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	self.hide()
	get_parent().show_tree("aoe_upgrade_button")


func _on_sniper_tree_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	self.hide()
	get_parent().show_tree("sniper_upgrade_button")
