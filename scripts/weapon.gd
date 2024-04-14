extends Node2D

class_name Weapon

@onready var timer = get_child(0)

var cool_down = 0.1
var is_ready : bool = true
var type = "AR"


const ar_cursor = ""

func _ready():
	timer.wait_time = cool_down

func _process(delta):
	shoot()

func shoot():
	if Input.is_action_pressed("left_click") and is_ready:
		is_ready = false
		timer.start()
		var game = get_parent()
		var enemies = game.get_all_enemies()
		var tanks = game.get_tank_enemies()
		var mouse_position = get_global_mouse_position()
		
		for tank in tanks:
			var barrier = tank.get_child(2)
			
			if barrier != null:
				var colliderSize = barrier.get_shape().get_rect().size
				
				if collidesWithPoint(mouse_position, tank.position, colliderSize):
					barrier.hp = barrier.hp - 1
					print("daño barrera")
					return
		
		for enemy in enemies:
			var colliderSize = enemy.get_child(1).get_shape().get_rect().size
		
			if collidesWithPoint(mouse_position, enemy.position, colliderSize):
				enemy.hp = enemy.hp - 1
				var sprite = enemy.get_child(0)
				sprite.modulate = Color(1, 0, 0) # Rojo
				enemy.damageTimer = 3
				break
			

func collidesWithPoint(point, pos, size):
	
	if point.x >= pos.x - size[0]/2 and point.x <= pos.x + size[0]/2: # la posición del personaje está centrica al objeto, no en la esquina superior izquierda
		if point.y >= pos.y - size[1]/2 and point.y <= pos.y + size[1]/2:
			return true
	
	return false

func _on_primary_cooldown_timeout():
	is_ready = true
