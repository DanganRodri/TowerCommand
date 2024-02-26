extends CharacterBody2D

class_name Enemy

@onready var tilemap = get_node("../TileMap")
var current_path: Array[Vector2i]

var type = "Basic"
var hp = 3
var speed = 1.5
var maxSpeed = 150

func _init(_type, _hp, _speed,_maxSpeed) -> void:
	self.type = _type
	self.hp = _hp
	self.speed = speed
	self.maxSpeed = _maxSpeed
	
	print("Mi tipo es: ", self.type)

func get_route():
	current_path = tilemap.graph.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(Vector2(432,272))
	).slice(1)

func _process(delta):
	
	if current_path.is_empty():
		get_route()
		return
	
	var target_position = tilemap.map_to_local(current_path.front())
	global_position = global_position.move_toward(target_position, self.speed)
	
	if global_position == target_position:
		current_path.pop_front()
	
	
	pass


