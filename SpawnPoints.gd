extends Node

var enemy_basic = preload("res://entities/enemy_basic.tscn")
var enemy_tank = preload("res://entities/enemy_tank.tscn")
var enemy_speedy = preload("res://entities/enemy_speedy.tscn")

@onready var waveTimer = $WaveTimer
@onready var waveIndicator = $WaveIndicatorBackGround/WaveIndicator
@onready var spawn_interval = $SpawnInterval


var wave : int = 0
var wave1 = [[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"]]
var wave2 = [[1,"basic"],[1,"tank"],[1,"basic"],[1,"basic"],[1,"tank"],[1,"basic"]]
var wave3 = [[2,"basic"],[2,"basic"],[2,"basic"],[2,"basic"],[2,"basic"],[2,"basic"],[2,"basic"],[2,"basic"],[2,"basic"]]
var wave4 = [[1,"basic"],[1,"tank"],[1,"basic"],[1,"basic"],[1,"tank"],[1,"basic"]]
var waveList = [wave1, wave2, wave3, wave4]
var spawnDelay : float = 1
var spawn_ready : bool = true
var wave_ended : bool = true
var wave_interval : float = 17.5
var last_wave : bool = false
var totalWaves = waveList.size()


func _ready():
	waveTimer.wait_time = wave_interval * GameData.Challenges["TimeBetweenWaves"]
	waveTimer.start()
	waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)

func _process(delta):
	if last_wave:
		return
	
	if not last_wave and spawn_ready:
		spawnWave()
	
func spawnWave():
	
	if waveList[wave].is_empty():
		return
	
	if waveList.size() == wave + 1:
		last_wave = true
		waveTimer.stop()
	
	spawn_ready = false
	wave_ended = false
	spawn_interval.start()
	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	
	var spawnInfo = waveList[wave][0]
	var enemy = instantiateEnemy(spawnInfo[1])
	var spawnPoint = spawn_points[spawnInfo[0]]
	enemy.position = spawnPoint.position
	get_parent().add_child(enemy)
	waveList[wave].remove_at(0)
	
	

func instantiateEnemy(type):
	
	var enemy
	
	match type:
		"basic":
			enemy = enemy_basic.instantiate()
		"tank":
			enemy = enemy_tank.instantiate()
		"speedy":
			enemy = enemy_speedy.instantiate()
	
	return enemy


func _on_wave_timer_timeout():
	wave_ended = true
	wave = wave + 1
	waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)




func _on_spawn_interval_timeout():
	spawn_ready = true
