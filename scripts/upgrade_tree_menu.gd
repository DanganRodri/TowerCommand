extends Panel

var turrets = null
@onready var select_tree = $"Select Tree"

func _on_exit_pressed():
	self.hide()
	hide_upgrade_buttons()

func hide_upgrade_buttons():
	var upgrade_buttons = get_tree().get_nodes_in_group("upgradebutton")
	for ub in upgrade_buttons:
		ub.hide()

func _on_open_upgrade_menu_pressed():
	get_tree().paused = true
	turrets = get_tree().root.get_node("Game").get_node("Turrets")
	self.show()
	select_tree.show()

func show_tree(tree_group: String):
	match tree_group:
		"dps_upgrade_button":
			var dps_upgrade_buttons = get_tree().get_nodes_in_group(tree_group)
			for dub in dps_upgrade_buttons:
				dub.show()
		"ice_upgrade_button":
			var ice_upgrade_buttons = get_tree().get_nodes_in_group(tree_group)
			for iub in ice_upgrade_buttons:
				iub.show()
		"aoe_upgrade_button":
			var aoe_upgrade_buttons = get_tree().get_nodes_in_group(tree_group)
			for aub in aoe_upgrade_buttons:
				aub.show()
		"sniper_upgrade_button":
			var sniper_upgrade_buttons = get_tree().get_nodes_in_group(tree_group)
			for sub in sniper_upgrade_buttons:
				sub.show()

func _input(event):
	if event is InputEventKey and event.is_action_pressed("esc"):
		_on_exit_pressed()


func _on_return_pressed():
	select_tree.show()
	hide_upgrade_buttons()
