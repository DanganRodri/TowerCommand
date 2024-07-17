extends CanvasLayer

@onready var pause_button = %Pause_button
@onready var fastforward_button = %Fastforward_button
@onready var upgrade_tree = %UpgradeTree
@onready var pause_panel = $PausePanel
@onready var back_ground = $PausePanel/BackGround
@onready var game = $".."
@onready var unpause_timer = $PausePanel/UnpauseTimer
@onready var countdown = $PausePanel/Countdown

var on_upgrade_menu : bool = false
var on_unpause : bool = false

func _input(event):
	if event is InputEventKey and event.is_action_pressed("Pause") and not on_upgrade_menu:
		#pause_button.button_pressed = !pause_button.button_pressed
		_on_pause_button_pressed()
		return
	if event is InputEventKey and event.is_action_pressed("Fastforward"):
		_on_fastforward_button_pressed()
		return
	if event is InputEventKey and event.is_action_pressed("open_upgrade_tree"):
		on_upgrade_menu = true
		upgrade_tree._on_open_upgrade_menu_pressed()
		return

func _on_fastforward_button_pressed():
	if not GameData.game_ended:
		AudioHandler.play_SFX("res://SFX/button_pressed.wav")
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

func unpause_countdown():
	on_unpause = true
	pause_panel.show()
	unpause_timer.start()
	back_ground.hide()
	countdown.show()

func _on_pause_button_pressed():
	
	if not GameData.game_ended:
		CursorManager.on_menu_enter()
		AudioHandler.play_SFX("res://SFX/button_pressed.wav")
		if get_tree().is_paused():
			if not on_unpause:
				unpause_countdown()
		else:
			pause_panel.show()
			get_tree().paused = true


func _on_exit_button_pressed():
	CursorManager.on_menu_exit()
	if get_tree().is_paused():
		get_tree().paused = false
	
	GameData.full_reset()
	
	get_tree().change_scene_to_file("res://scenes/menu_handler.tscn")


func _on_continue_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	_on_pause_button_pressed()


func _on_restart_button_pressed():
	CursorManager.on_menu_exit()
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	var rootNode = get_tree().root.get_node("SceneHandler")
	
	if get_tree().is_paused():
		get_tree().paused = false
	
	Engine.set_time_scale(1.0)
	
	GameData.reset_bonuses()
	
	var game_scene = load("res://scenes/game.tscn").instantiate()
	game.queue_free()
	rootNode.add_child(game_scene)


func _on_unpause_timer_timeout():
	CursorManager.on_menu_exit()
	on_unpause = false
	back_ground.show()
	countdown.hide()
	pause_panel.hide()
	get_tree().paused = false
