extends CanvasLayer

@onready var pause_button = %Pause_button
@onready var fastforward_button = %Fastforward_button
@onready var upgrade_tree = %UpgradeTree

func _input(event):
	if event is InputEventKey and event.is_action_pressed("Pause"):
		pause_button.button_pressed = !pause_button.button_pressed
		_on_pause_button_pressed()
		return
	if event is InputEventKey and event.is_action_pressed("Fastforward"):
		_on_fastforward_button_pressed()
		return
	if event is InputEventKey and event.is_action_pressed("open_upgrade_tree"):
		upgrade_tree._on_open_upgrade_menu_pressed()
		return

func _on_fastforward_button_pressed():
	
	if Engine.get_time_scale() == GameData.SLOWMOTION:
		return
	
	if GameData.FASTFORWARD_STAGES.size() - 1 == GameData.fastforward_actual_stage:
		GameData.fastforward_actual_stage = 0
		Engine.set_time_scale(GameData.FASTFORWARD_STAGES[GameData.fastforward_actual_stage])
	else:
		GameData.fastforward_actual_stage += 1
		Engine.set_time_scale(GameData.FASTFORWARD_STAGES[GameData.fastforward_actual_stage])
	
	var label = fastforward_button.get_node("Speed")
	label.text = "x" + str(GameData.FASTFORWARD_STAGES[GameData.fastforward_actual_stage])

func _on_pause_button_pressed():
	if get_tree().is_paused():
		get_tree().paused = false
	else:
		get_tree().paused = true
