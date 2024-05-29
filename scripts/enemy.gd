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
var protected : Barrier = null

var slow_timer : Timer

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

func get_route():
	current_path = tilemap.graph.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(target)
	).slice(1)

func on_hit(damage):
	
	if protected != null:
		protected.on_hit(damage)
		return
	
	if get_node("Barrier"):
		get_node("Barrier").on_hit(damage)
		return
	
	damaged = true
	damage_timer.start()
	hp -= damage
	if self.hp <= 0:
		on_destroy()

func status_effect(effect,duration,value):
	match effect:
		"slow":
			slow_timer.wait_time = duration
			slow_timer.start()
			self.speed = self.speed * value
			slowed = true
			

func on_destroy():
	var game = get_parent()
	game.gold = game.gold + self.gold
	self.queue_free()
	
func apply_color_filter():
	if self.damaged:
		sprite.modulate = Color(1, 0, 0) # Rojo
		return
	if self.slowed:
		sprite.modulate = Color(0.4, 0.83, 1) # Azul claro
		return

func get_target():
	var towers = self.get_parent().get_node("Towers").get_children()
	var tower = Game.check_closest(self, towers)
	target = tower.position
	pass

func _process(delta):
	
	if color == Color():
		color = sprite.modulate
	
	apply_color_filter()
	
	if not current_path.is_empty():
		var target_position = tilemap.map_to_local(current_path.front())
		global_position = global_position.move_toward(target_position, self.speed)
	
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
