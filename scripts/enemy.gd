extends CharacterBody2D

class_name Enemy

@onready var tilemap = get_node("../TileMap")
@onready var sprite = get_node("Sprite2D")
var current_path: Array[Vector2i]
var target: Vector2

var type : String = "Basic"
var hp : float = 3.0
var speed : float = 1.5
var maxSpeed : int = 150
var color : Color = Color()
var damageTimer : int = 0
var inmune : bool = false
var gold : int = 10

func _init(_type, _hp, _speed,_maxSpeed,_inmune, _gold) -> void:
	self.type = _type
	self.hp = _hp
	self.speed = _speed
	self.maxSpeed = _maxSpeed
	self.inmune = _inmune
	self.gold = _gold

func _ready():
	get_target()
	get_route()

func get_route():
	current_path = tilemap.graph.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(target)
	).slice(1)

func on_hit(damage):
	hp -= damage
	sprite.modulate = Color(1, 0, 0) # Rojo
	self.damageTimer = 3
	if self.hp <= 0:
		on_destroy()
	
func on_destroy():
	var game = get_parent()
	game.gold = game.gold + self.gold
	self.queue_free()
	
func resetColor():
	if damageTimer == 0:
		sprite.modulate = color
	else:
		damageTimer = damageTimer - 1

func get_target():
	var towers = self.get_parent().get_node("Towers").get_children()
	var tower = Game.check_closest(self, towers)
	target = tower.position
	pass

func _process(delta):
	
	if color == Color():
		color = sprite.modulate
	
	resetColor()
	
	if not current_path.is_empty():
		var target_position = tilemap.map_to_local(current_path.front())
		global_position = global_position.move_toward(target_position, self.speed)
	
		if global_position == target_position:
			current_path.pop_front()
	
	pass
