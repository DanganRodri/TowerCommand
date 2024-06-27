extends CharacterBody2D

class_name Enemy

@onready var tilemap = get_node("../TileMap")
@onready var sprite = get_node("AnimatedSprite2D")
var current_path: Array[Vector2i]
var target: Vector2
var type : String = "Basic"
var hp : float = 3.0
var def : float = 1.0
var speed : float = 1.5
var base_speed : float = speed
var maxSpeed : int = 150
var color : Color = Color()
var damage_timer : Timer
var gold : int = 10

#Status effects
var damaged : bool = false
var inmune : bool = false
var slowed : bool = false
var freezed : bool = false
var burned : bool = false
var poisoned : bool = false
var poison_staks : int = 0
var weakened : bool = false
var stunned : bool = false
var stealth : bool = false
var protected : Array[Barrier] = []

var slow_timer : Timer
var poison_timer : Timer
var poison_dot : Timer
var freeze_timer : Timer
var stun_timer : Timer
var burn_timer : Timer
var burn_dot : Timer

func _init(_type, _hp, _def, _speed,_maxSpeed,_inmune) -> void:
	self.type = _type
	self.hp = _hp
	self.def = _def
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
	
	stun_timer = Timer.new()
	stun_timer.wait_time = GameData.BASE_STUN_DURATION
	stun_timer.one_shot = true
	stun_timer.connect("timeout", Callable(self, "_on_stun_timer_timeout"))
	add_child(stun_timer)
	
	burn_timer = Timer.new()
	burn_timer.wait_time = 0.75
	burn_timer.one_shot = true
	burn_timer.connect("timeout", Callable(self, "_on_burn_timer_timeout"))
	add_child(burn_timer)
	
	burn_dot = Timer.new()
	burn_dot.wait_time = GameData.BASE_BURN_DOT
	burn_dot.one_shot = true
	burn_dot.connect("timeout", Callable(self, "_on_burn_dot"))
	add_child(burn_dot)
	
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

func on_hit(damage, def_pen):
	
	if self.inmune:
		return
	
	def_pen = min(def_pen, 100.0)
	damage = damage - (def * ( 1.0 - def_pen / 100.0 ))
	
	if weakened:
		if self.type == "Boss":
			damage *= (GameData.stat_bonus["weakened_value"] / 2 )
		else:
			damage *= GameData.stat_bonus["weakened_value"]
		
	damage = damage * GameData.Challenges["EnemyDamageTaken"]
	
	if not protected.is_empty():
		protected[0].on_hit(damage)
		return
	
	damaged = true
	damage_timer.start()
	hp -= damage
	if self.hp <= 0:
		on_destroy()

func status_effect(effect,duration,value):
	
	if self.inmune:
		return
	
	match effect:
		"slow":
			slow_timer.wait_time = duration * GameData.stat_bonus["slow_duration"]
			slow_timer.start()
			if not slowed:
				self.speed = self.speed * (value / GameData.stat_bonus["slow"])
				slowed = true
		
		"freeze":
			if self.type == "Boss":
				return
			freeze_timer.wait_time = duration
			freeze_timer.start()
			self.speed = 0
			self.sprite.stop()
			freezed = true
			
		"stun":
			stun_timer.wait_time = duration
			stun_timer.start()
			self.speed = 0
			self.sprite.stop()
			stunned = true
			self.inmune = false
			self.stealth = false
		
		"poison":
			poison_timer.wait_time = duration
			poison_timer.start()
			if not self.poisoned:
				poison_dot.start()
			self.poisoned = true
			if self.type == "Boss":
				self.poison_staks += min(value * GameData.stat_bonus["poison_dot"], GameData.MAX_BOSS_POISON_STAKS)
			else:
				self.poison_staks += value * GameData.stat_bonus["poison_dot"]
				
		"weaken":
			self.weakened = true
		
		"burn":
			burn_timer.wait_time = duration
			burn_timer.start()
			if not self.burned:
				burn_dot.start()
			self.burned = true

func on_destroy():
	var game = get_parent()
	game.gold = min(GameData.MAX_GOLD, game.gold + (self.gold * GameData.Challenges["GoldGainPercentage"]) )
	self.queue_free()
	
func apply_color_filter():
	if self.inmune:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["INMUNE_COLOR"]
		return
	if self.damaged:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["DAMAGED_COLOR"]
		return
	if self.stealth:
		sprite.modulate = Color(color,0.65)
		return
	if self.stunned:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["STUN_COLOR"]
		return
	if self.poisoned:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["POISONED_COLOR"]
		return
	if self.freezed:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["FREEZED_COLOR"]
		return
	if self.slowed:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["SLOWED_COLOR"]
		return
	if self.burned:
		sprite.modulate = GameData.COLOR_DATA["STATUS"]["BURNED_COLOR"]
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
		var collision = self.get_node("CollisionShape2D")
		var shape = collision.shape
		var height = shape.extents.y
		target_position[1] -= height / 2
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

func _on_stun_timer_timeout():
	self.speed = base_speed
	sprite.modulate = color
	self.sprite.play("run")
	stunned = false

func _on_burn_timer_timeout():
	self.burned = false
	sprite.modulate = color

func _on_burn_dot():
	self.hp -= GameData.BASE_BURN_DAMAGE + GameData.stat_bonus["burn_damage"]
	if self.hp <= 0:
		self.on_destroy()
	if self.burned:
		burn_dot.start()

func _on_poison_timer_timeout():
	self.poisoned = false
	self.weakened = false
	sprite.modulate = color
	self.poison_staks = 0

func _on_poison_dot():
	self.hp -= self.poison_staks
	if self.hp <= 0:
		self.on_destroy()
	if self.poisoned:
		poison_dot.start()
