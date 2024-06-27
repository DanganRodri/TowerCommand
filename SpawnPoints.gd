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

var basic_size

var wave : int = 0
var wave1 = [[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"],[0,"basic"]]
var wave2 = [[1,"basic"],[1,"tank"],[1,"basic"],[1,"basic"],[1,"tank"],[1,"basic"]]
var wave3 = [[2,"basic"],[2,"speedy"],[2,"basic"],[2,"jammer"],[2,"basic"],[2,"stealth"],[2,"basic"],[2,"basic"],[2,"basic"]]
var wave4 = [[1,"basic"],[1,"tank"],[1,"basic"],[1,"basic"],[1,"tank"],[1,"basic"],[1,"boss"]]
var waveList = [wave1, wave2, wave3, wave4]
var spawnDelay : float = 1
var spawn_ready : bool = true
var wave_ended : bool = true
var wave_interval : float = 20
var last_wave : bool = false
var totalWaves = waveList.size()


func _ready():
	waveTimer.wait_time = wave_interval * GameData.Challenges["TimeBetweenWaves"]
	waveTimer.start()
	waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)
	
	var basic_enemy = instantiateEnemy("basic")
	var collision = basic_enemy.get_node("CollisionShape2D")
	var shape = collision.shape
	basic_size = shape.extents.x
	basic_enemy.queue_free()

func _process(delta):
	if last_wave:
		return
	
	if not last_wave and spawn_ready:
		spawnWave()
	
func spawnWave():
	
	if waveList.size() == wave + 1:
		if waveList[wave].is_empty():
			last_wave = true
		waveTimer.stop()
	
	if waveList[wave].is_empty():
		return
	
	spawn_ready = false
	wave_ended = false
	
	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	
	var spawnInfo = waveList[wave][0]
	var enemy = instantiateEnemy(spawnInfo[1])
	var spawnPoint = spawn_points[spawnInfo[0]]
	var collision = enemy.get_node("CollisionShape2D")
	var shape = collision.shape
	var height = shape.extents.y
	enemy.position = spawnPoint.position
	enemy.position[1] -= height / 2
	get_parent().add_child(enemy)
	waveList[wave].remove_at(0)
	
	if not waveList[wave].is_empty():
		var next_spawnInfo = waveList[wave][0]
		var next_enemy = instantiateEnemy(next_spawnInfo[1])
		var next_collision = next_enemy.get_node("CollisionShape2D")
		var next_shape = next_collision.shape
		var long = next_shape.extents.x
		var interval_size_multiplier = abs((long - basic_size) / basic_size)
		basic_size = long
		next_enemy.queue_free()
		spawn_interval.wait_time = GameData.SPAWN_INTERVAL_BASE * (1.1 + interval_size_multiplier)
		spawn_interval.start()
	else:	
		spawn_interval.wait_time = GameData.SPAWN_INTERVAL_BASE
		spawn_interval.start()
	

func instantiateEnemy(type):
	
	var enemy
	
	match type:
		"basic":
			enemy = enemy_basic.instantiate()
		"tank":
			enemy = enemy_tank.instantiate()
		"jammer":
			enemy = enemy_jammer.instantiate()
		"speedy":
			enemy = enemy_speedy.instantiate()
		"stealth":
			enemy = enemy_stealth.instantiate()
		"boss":
			enemy = enemy_boss.instantiate()
	
	return enemy


func _on_wave_timer_timeout():
	wave_ended = true
	wave = wave + 1
	waveIndicator.text = "Wave: " + str(wave+1) + "/" + str(totalWaves)


func _on_spawn_interval_timeout():
	spawn_ready = true
