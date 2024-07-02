extends Node

class_name Wave

var enemy_basic = preload("res://entities/enemy_basic.tscn")
var enemy_tank = preload("res://entities/enemy_tank.tscn")
var enemy_jammer = preload("res://entities/enemy_jammer.tscn")
var enemy_speedy = preload("res://entities/enemy_speedy.tscn")
var enemy_stealth = preload("res://entities/enemy_stealth.tscn")
var enemy_boss = preload("res://entities/enemy_boss.tscn")

var spawnPoint : Marker2D
var enemyList = []
var spawnDelay : Timer
var started : bool = false
var spawn_ready : bool = true

var basic_size

func _ready():
	spawnDelay = Timer.new()
	spawnDelay.wait_time = GameData.SPAWN_INTERVAL_BASE
	spawnDelay.one_shot = true
	spawnDelay.connect("timeout", Callable(self, "_on_spawn_delay"))
	add_child(spawnDelay)
	
	var basic_enemy = instantiateEnemy("basic")
	var collision = basic_enemy.get_node("CollisionShape2D")
	var shape = collision.shape
	basic_size = shape.extents.x
	basic_enemy.queue_free()

func _process(delta):
	if started and spawn_ready:
		spawn_enemy()


func spawn_enemy():
	
	if enemyList.is_empty():
		started = false
		return
	
	spawn_ready = false
	
	var enemy = instantiateEnemy(enemyList[0])
	var collision = enemy.get_node("CollisionShape2D")
	var shape = collision.shape
	var height = shape.extents.y
	enemy.position = spawnPoint.position
	enemy.position[1] -= height / 2
	spawnPoint.get_parent().get_parent().add_child(enemy) #ajustarlo
	
	if enemyList.size() > 1:
		var next_enemy = instantiateEnemy(enemyList[1])
		var next_collision = next_enemy.get_node("CollisionShape2D")
		var next_shape = next_collision.shape
		var long = next_shape.extents.x
		var interval_size_multiplier = abs((long - basic_size) / basic_size)
		basic_size = long
		next_enemy.queue_free()
		spawnDelay.wait_time = GameData.SPAWN_INTERVAL_BASE * (1.1 + interval_size_multiplier)
		spawnDelay.start()
	else:
		spawnDelay.wait_time = GameData.SPAWN_INTERVAL_BASE
		spawnDelay.start()
	
	enemyList.remove_at(0)

func set_wave(waveList, spawPosition : Marker2D):
	
	for enemy in waveList:
		enemyList.append(enemy)
	
	spawnPoint = spawPosition

func instantiateEnemy(type) -> Enemy:
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

func start():
	started = true

func _on_spawn_delay():
	spawn_ready = true
