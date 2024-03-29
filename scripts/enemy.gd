extends CharacterBody2D

class_name Enemy

@onready var tilemap = get_node("../TileMap")
@onready var sprite = get_node("Sprite2D")
var current_path: Array[Vector2i]

var type = "Basic"
var hp = 3
var speed = 1.5
var maxSpeed = 150
var color = Color()
var damageTimer = 0

func _init(_type, _hp, _speed,_maxSpeed) -> void:
	self.type = _type
	self.hp = _hp
	self.speed = speed
	self.maxSpeed = _maxSpeed

func get_route():
	current_path = tilemap.graph.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(Vector2(432,272))
	).slice(1)
	
func checkIfDead():
	if self.hp <= 0:
		return true
	return false

func resetColor():
	if damageTimer == 0:
		sprite.modulate = color
	else:
		damageTimer = damageTimer - 1

func _process(delta):
	
	if checkIfDead():
		self.queue_free()
		pass
	
	if color == Color():
		color = sprite.modulate
	
	resetColor()
	
	if current_path.is_empty():
		get_route()
		return
	
	var target_position = tilemap.map_to_local(current_path.front())
	global_position = global_position.move_toward(target_position, self.speed)
	
	if global_position == target_position:
		current_path.pop_front()
	
	pass
