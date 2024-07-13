extends Node

var enemy_basic = preload("res://entities/enemy_basic.tscn")
var enemy_tank = preload("res://entities/enemy_tank.tscn")
var enemy_jammer = preload("res://entities/enemy_jammer.tscn")
var enemy_speedy = preload("res://entities/enemy_speedy.tscn")
var enemy_stealth = preload("res://entities/enemy_stealth.tscn")
var enemy_boss = preload("res://entities/enemy_boss.tscn")

@onready var waveTimer = $WaveTimer
@onready var waveIndicator = $WaveIndicatorBackGround/WaveIndicator
@onready var spawn_interval = $SpawnInterval

var wave : int = 0
var waveList = []
var spawn_ready : bool = true
var wave_ended : bool = true
var wave_interval : float = 20
var last_wave : bool = false
var totalWaves = 0
var wave_size = 15

func _ready():
	waveTimer.wait_time = wave_interval * GameData.Challenges["TimeBetweenWaves"]
	waveTimer.start()
	
	if GameData.Challenges["Endless"]:
		generate_wave()
	else:
		set_level(WaveData.LEVEL1)
	
	var totalWaves = waveList.size()

	if GameData.Challenges["Endless"] == true:
		waveIndicator.text = "Wave:   " + str(wave+1)
	else:
		waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)
	
func generate_wave():
	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	var new_wave = Wave.new()
	var enemyList = []
	var spawnPoint = spawn_points.pick_random()
	enemyList = generate_enemy_list()
	
	new_wave.set_wave(enemyList,spawnPoint)
	waveList.append(new_wave)
	add_child(new_wave)
	

func generate_enemy_list() -> Array[String]:
	var probabilities = []
	
	for enemy_type in WaveData.enemy_probabilities.keys():
		var prob = WaveData.enemy_probabilities[enemy_type]
		for i in prob:
			probabilities.append(enemy_type)
	
	var enemyList : Array[String] = []
	for i in wave_size:
		if i == wave_size-1 and ((wave+1) % 5) == 0:
			enemyList.append("boss")
		else:
			enemyList.append(probabilities.pick_random())
	
	update_probabilities()
	
	if (wave+1) % 5 == 0:
		wave_size += 1
	
	return enemyList

func update_probabilities():
	var dec_amount = 0
	var enemies = []
	var stealth_prob = WaveData.enemy_probabilities["stealth"]
	var speedy_prob = WaveData.enemy_probabilities["speedy"]
	
	if WaveData.enemy_probabilities["basic"] != 20:
		if wave == 0 or ((wave+1) % 5) == 0 and not wave == 10:
			dec_amount = 25
		else:
			dec_amount = 5
			
		WaveData.enemy_probabilities["basic"] = max(20, WaveData.enemy_probabilities["basic"]-dec_amount)
		enemies = set_prob_array( WaveData.increase_enemy_probabilities )
		
	elif stealth_prob > 10 and speedy_prob > 10:
		if stealth_prob > speedy_prob:
			dec_amount = 2
			WaveData.enemy_probabilities["stealth"] = max(10, WaveData.enemy_probabilities["stealth"]-dec_amount)
		if speedy_prob >= stealth_prob:
			dec_amount = 2
			WaveData.enemy_probabilities["speedy"] = max(10, WaveData.enemy_probabilities["speedy"]-dec_amount)
		
		enemies = set_prob_array( WaveData.increase_enemy_probabilities_advanced )
		
	if dec_amount == 0:
		return
	
	for i in dec_amount:
		var increase_prob = enemies.pick_random()
		WaveData.enemy_probabilities[increase_prob] += 1

func set_prob_array(dictionary) -> Array:
	var enemies = []
	for enemy_type in dictionary.keys():
		var prob = dictionary[enemy_type]
		for i in prob:
			enemies.append(enemy_type)
	
	return enemies

func set_level(level):
	var levelList = level
	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	
	var waveKey = levelList.keys()
	for wave in waveKey:
		wave = WaveData.LEVEL1[wave]
		var new_wave = Wave.new()
		new_wave.set_wave(wave["EnemyList"],spawn_points[wave["SpawnPoint"]])
		waveList.append(new_wave)
		add_child(new_wave)
	

func _process(delta):
	if last_wave:
		return
	
	if not last_wave and wave_ended:
		spawnWave()
	
func spawnWave():
	
	if GameData.Challenges["Endless"]:
		waveList[wave].start()
		waveTimer.wait_time = (GameData.WAVE_INTERVAL + waveList[wave].enemyList.size()) * GameData.Challenges["TimeBetweenWaves"]
		wave = wave + 1
		generate_wave()
		wave_ended = false
		waveTimer.start()
		return
	
	else:
		if waveList.size() == wave + 1:
			if waveList[wave].enemyList.is_empty():
				last_wave = true
			waveTimer.stop()
	
	if waveList[wave].enemyList.is_empty():
		return
	
	waveList[wave].start()
	waveTimer.wait_time = (GameData.WAVE_INTERVAL + waveList[wave].enemyList.size()) * GameData.Challenges["TimeBetweenWaves"]
	wave = wave + 1
	waveTimer.start()
	wave_ended = false
	


func _on_wave_timer_timeout():
	wave_ended = true
	if GameData.Challenges["Endless"] == true:
		waveIndicator.text = "Wave:   " + str(wave+1)
	else:
		waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)


func _on_spawn_interval_timeout():
	spawn_ready = true
