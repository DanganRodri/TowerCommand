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

func _ready():
	waveTimer.wait_time = wave_interval * GameData.Challenges["TimeBetweenWaves"]
	waveTimer.start()
	
	set_level()
	
	var totalWaves = waveList.size()
	waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)
	

func set_level():
	var levelList = WaveData.LEVEL1
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
	waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)


func _on_spawn_interval_timeout():
	spawn_ready = true
