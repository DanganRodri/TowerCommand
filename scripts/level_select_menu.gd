extends Control

@onready var level_selector = $LevelSelector
@onready var level_settings = $LevelSettings

func _on_play_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	var sliders = get_tree().get_nodes_in_group("challenge_slider")
	GameData.Challenges["GoldGainPercentage"] =  GameData.GOLD_GAIN_PERCENTAGE_LEVELS[sliders[0].value]
	GameData.Challenges["EnemyDamageReduction"] = GameData.ENEMY_DAMAGE_TAKEN_LEVELS[sliders[1].value]
	GameData.Challenges["TimeBetweenWaves"] = GameData.TIME_BETWEEN_WAVES_LEVELS[sliders[2].value]
	var check_button = get_tree().get_first_node_in_group("challenge_endless")
	
	if check_button.button_pressed:
		GameData.Challenges["Endless"] = true
	else:
		GameData.Challenges["Endless"] = false
		
	var game_scene = load("res://scenes/game.tscn").instantiate()
	AudioHandler.play_song("res://music/MainTheme.mp3")
	CursorManager.on_menu_exit()
	get_parent().add_child(game_scene)
	queue_free()


func _on_level_1_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	level_selector.hide()
	level_settings.show()


func _on_return_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	get_node("../MainMenu").show()
	self.hide()


func _on_reset_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	var sliders = get_tree().get_nodes_in_group("challenge_slider")
	for slider in sliders:
		slider.value = 0
	
	get_tree().get_nodes_in_group("challenge_endless")[0].button_pressed = false
