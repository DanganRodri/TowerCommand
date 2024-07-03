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
		enemyList.append(probabilities.pick_random())
	
	update_probabilities()
	
	return enemyList

func update_probabilities():
	if WaveData.enemy_probabilities["basic"] != 10:
		var dec_amount
		if wave == 0:
			dec_amount = 25
		else:
			dec_amount = 5
		
		WaveData.enemy_probabilities["basic"] -= dec_amount
		const enemies = ["tank","jammer","stealth","speedy"]
		for i in dec_amount:
			var increase_prob = enemies.pick_random()
			WaveData.enemy_probabilities[increase_prob] += 1

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
		generate_wave()
	
	else:
		if waveList.size() == wave + 1:
			if waveList[wave].enemyList.is_empty():
				last_wave = true
			waveTimer.stop()
	
	if waveList[wave].enemyList.is_empty():
		return
	
	waveList[wave].start()
	wave_ended = false


func _on_wave_timer_timeout():
	wave_ended = true
	wave = wave + 1
	if GameData.Challenges["Endless"] == true:
		waveIndicator.text = "Wave:   " + str(wave+1)
	else:
		waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)


func _on_spawn_interval_timeout():
	spawn_ready = true
