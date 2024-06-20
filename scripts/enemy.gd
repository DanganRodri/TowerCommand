extends CharacterBody2D

class_name Enemy

@onready var tilemap = get_node("../TileMap")
@onready var sprite = get_node("AnimatedSprite2D")
var current_path: Array[Vector2i]
var target: Vector2
var type : String = "Basic"
var hp : float = 3.0
var speed : float = 1.5
var base_speed : float = speed
var maxSpeed : int = 150
var color : Color = Color()
var damage_timer : Timer
var damaged : bool = false
var inmune : bool = false
var gold : int = 10
var slowed : bool = false
var freezed : bool = false
var poisoned : bool = false
var poison_staks : int = 0
var protected : Barrier = null

var slow_timer : Timer
var poison_timer : Timer
var poison_dot : Timer
var freeze_timer : Timer

func _init(_type, _hp, _speed,_maxSpeed,_inmune) -> void:
	self.type = _type
	self.hp = _hp
	self.speed = _speed
	self.base_speed = _speed
	self.maxSpeed = _maxSpeed
	self.inmune = _inmune
	self.gold = _hp * 0.75

func _ready():
	get_target()
	get_route()
	
	damage_timer = Timer.new()
	damage_timer.wait_time = 0.035
	damage_timer.one_shot = true
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	add_child(damage_timer)
	
	slow_timer = Timer.new()
	slow_timer.wait_time = 3.0
	slow_timer.one_shot = true
	slow_timer.connect("timeout", Callable(self, "_on_slow_timer_timeout"))
	add_child(slow_timer)
	
	freeze_timer = Timer.new()
	freeze_timer.wait_time = 0.75
	freeze_timer.one_shot = true
	freeze_timer.connect("timeout", Callable(self, "_on_freeze_timer_timeout"))
	add_child(freeze_timer)
	
	poison_timer = Timer.new()
	poison_timer.wait_time = GameData.BASE_POISON_DURATION
	poison_timer.one_shot = true
	poison_timer.connect("timeout", Callable(self, "_on_poison_timer_timeout"))
	add_child(poison_timer)
	
	poison_dot = Timer.new()
	poison_dot.wait_time = GameData.BASE_POISON_DOT
	poison_dot.one_shot = true
	poison_dot.connect("timeout", Callable(self, "_on_poison_dot"))
	add_child(poison_dot)

func get_route():
	current_path = tilemap.graph.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(target)
	).slice(1)

func on_hit(damage):
	
	damage = damage * GameData.Challenges["EnemyDamageTaken"]
	
	if protected != null:
		protected.on_hit(damage)
		return
	
	damaged = true
	damage_timer.start()
	hp -= damage
	if self.hp <= 0:
		on_destroy()

func status_effect(effect,duration,value):
	match effect:
		"slow":
			slow_timer.wait_time = duration * GameData.stat_bonus["slow_duration"]
			slow_timer.start()
			if not slowed:
				self.speed = self.speed * (value / GameData.stat_bonus["slow"])
				slowed = true
		
		"freeze":
			freeze_timer.wait_time = duration
			freeze_timer.start()
			self.speed = 0
			self.sprite.stop()
			freezed = true
		
		"poison":
			poison_timer.wait_time = duration
			poison_timer.start()
			if not self.poisoned:
				poison_dot.start()
			self.poisoned = true
			self.poison_staks += value
			

func on_destroy():
	var game = get_parent()
	game.gold = min(GameData.MAX_GOLD, game.gold + (self.gold * GameData.Challenges["GoldGainPercentage"]) )
	self.queue_free()
	
func apply_color_filter():
	if self.damaged:
		sprite.modulate = Color(1, 0, 0) # Rojo
		return
	if self.poisoned:
		sprite.modulate = Color(0.01300281099975, 0.62915825843811, 0) # Rojo
		return
	if self.freezed:
		sprite.modulate = Color(0, 0.17647059261799, 0.60392159223557) # Azul claro
		return
	if self.slowed:
		sprite.modulate = Color(0.4, 0.83, 1) # Azul claro
		return

func get_target():
	var towers = self.get_parent().get_node("Towers").get_children()
	var tower = GlobalFunctions.check_closest(self, towers)
	target = tower.position
	pass

func _process(delta):
	
	if color == Color():
		color = sprite.modulate
	
	apply_color_filter()
	
	if not current_path.is_empty():
		var target_position = tilemap.map_to_local(current_path.front())
		global_position = global_position.move_toward(target_position, self.speed * delta)
	
		if global_position == target_position:
			current_path.pop_front()
	
	pass

func _on_damage_timer_timeout():
	sprite.modulate = color
	damaged = false

func _on_slow_timer_timeout():
	speed = base_speed
	sprite.modulate = color
	slowed = false

func _on_freeze_timer_timeout():
	self.speed = base_speed
	sprite.modulate = color
	self.sprite.play("run")
	freezed = false

func _on_poison_timer_timeout():
	self.poisoned = false
	sprite.modulate = color
	self.poison_staks = 0

func _on_poison_dot():
	self.hp -= self.poison_staks
	if self.poisoned:
		poison_dot.start()
