extends Control

@onready var level_selector = $LevelSelector
@onready var level_settings = $LevelSettings
@onready var scene_handler = $".."

func _on_play_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	var sliders = get_tree().get_nodes_in_group("challenge_slider")
	GameData.Challenges["GoldGainPercentage"] =  GameData.GOLD_GAIN_PERCENTAGE_LEVELS[sliders[0].value]
	GameData.Challenges["EnemyDamageReduction"] = GameData.ENEMY_DAMAGE_TAKEN_LEVELS[sliders[1].value]
	GameData.Challenges["TimeBetweenWaves"] = GameData.TIME_BETWEEN_WAVES_LEVELS[sliders[2].value]
	GameData.score_increase =  sliders[0].value + sliders[1].value + sliders[2].value
	var check_button = get_tree().get_first_node_in_group("challenge_endless")
	
	if check_button.button_pressed:
		GameData.Challenges["Endless"] = true
		GameData.initial_gold = GameData.INITIAL_GOLD_ENDLESS
	else:
		GameData.initial_gold = GameData.INITIAL_GOLD_CAMPAING + ( (GameData.level - 1) * 75)
		GameData.Challenges["Endless"] = false
	
	GameData.gold = GameData.initial_gold
	var game_scene = load(scene_handler.level_path).instantiate()
	AudioHandler.play_song("res://music/MainTheme.mp3")
	CursorManager.on_menu_exit()
	get_parent().add_child(game_scene)
	queue_free()

func set_level(level):
	GameData.level = level
	scene_handler.level_path = GameData.LEVEL_PATH + str( GameData.level ) + ".tscn"
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	level_selector.hide()
	level_settings.show()

func _on_return_total_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	get_node("../MainMenu").show()
	self.hide()
	
func _on_return_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	level_selector.show()
	level_settings.hide()


func _on_reset_button_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	var sliders = get_tree().get_nodes_in_group("challenge_slider")
	for slider in sliders:
		slider.value = 0
	
	get_tree().get_nodes_in_group("challenge_endless")[0].button_pressed = false


func _on_level_1_button_pressed():
	set_level(1)

func _on_level_2_button_pressed():
	set_level(2)


func _on_level_3_button_pressed():
	set_level(3)



	
