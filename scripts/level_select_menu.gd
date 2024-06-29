extends Control

@onready var level_selector = $LevelSelector
@onready var level_settings = $LevelSettings


func _on_play_button_pressed():
	var sliders = get_tree().get_nodes_in_group("challenge_slider")
	GameData.Challenges["GoldGainPercentage"] =  GameData.GOLD_GAIN_PERCENTAGE_LEVELS[sliders[0].value]
	GameData.Challenges["EnemyDamageReduction"] = GameData.ENEMY_DAMAGE_TAKEN_LEVELS[sliders[1].value]
	GameData.Challenges["TimeBetweenWaves"] = GameData.TIME_BETWEEN_WAVES_LEVELS[sliders[2].value]
	
	var game_scene = load("res://scenes/game.tscn").instantiate()
	get_parent().add_child(game_scene)
	queue_free()


func _on_level_1_button_pressed():
	level_selector.hide()
	level_settings.show()


func _on_return_pressed():
	get_node("../MainMenu").show()
	self.hide()


func _on_reset_button_pressed():
	var sliders = get_tree().get_nodes_in_group("challenge_slider")
	for slider in sliders:
		slider.value = 0
	
	get_tree().get_nodes_in_group("challenge_endless")[0].button_pressed = false
