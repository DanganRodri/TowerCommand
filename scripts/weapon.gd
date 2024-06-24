extends Node2D

class_name Weapon

@onready var timer = get_child(0)

var weapon_type = {
	"AR": 0,
	"SG": 1,
	"RL": 2
}

var atk_speed = 0.1
var is_ready : bool = true
var type = weapon_type.AR
var damage = 4


const ar_cursor = ""

func _ready():
	timer.wait_time = atk_speed

func _process(delta):
	shoot()

func shoot():
	if Input.is_action_pressed("left_click") and is_ready:
		is_ready = false
		timer.start()
		var game = get_parent()
		var enemies = game.get_all_enemies()
		var tanks = game.get_tank_enemies()
		var speedies = game.get_speedy_enemies()
		var mouse_position = get_global_mouse_position()
		
		for speedie in speedies:
			var shields = speedie.get_child(2)
			for shield in shields.get_children():
				if shield is Shield and shield.disabled == false:
					var colliderSize = shield.get_shape().get_rect().size
					if collidesWithPoint(mouse_position, shield.position + speedie.position, colliderSize):
						shield.hitted = true
						return
		
		for enemy in enemies:
			var colliderSize = enemy.get_child(1).get_shape().get_rect().size
		
			if collidesWithPoint(mouse_position, enemy.position, colliderSize) and enemy.inmune == false:
				enemy.on_hit(self.damage, 0)
				break
			

func collidesWithPoint(point, pos, size):
	
	if point.x >= pos.x - size[0]/2 and point.x <= pos.x + size[0]/2: # la posición del personaje está centrica al objeto, no en la esquina superior izquierda
		if point.y >= pos.y - size[1]/2 and point.y <= pos.y + size[1]/2:
			return true
	
	return false

func _on_primary_cooldown_timeout():
	is_ready = true
