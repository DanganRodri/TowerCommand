extends Node2D

class_name Weapon

@onready var timer = get_node("PrimaryCooldown")
@onready var sprite_timer = $SpriteTimer

var weapon_type = {
	"AR": 0,
	"SG": 1,
	"RL": 2
}

var atk_speed = 0.1
var is_ready : bool = true
var type = weapon_type.AR
var atk = 4
var def_pen = 0.2


const cursor = preload("res://assets/HUD/cursor_big.png")
const shoting_cursor = preload("res://assets/HUD/cursor_big_shoting.png")

func _ready():
	timer.wait_time = atk_speed
	sprite_timer.wait_time = atk_speed / 3

func _process(delta):	
	shoot()

func shoot():
	if Input.is_action_pressed("left_click") and is_ready:
		var game = get_parent()
		var enemies = get_tree().get_nodes_in_group("enemy")
		var tanks = get_tree().get_nodes_in_group("tank")
		var shields = get_tree().get_nodes_in_group("shield")
		var mouse_position = get_global_mouse_position()
		
		var barriers = get_tree().get_nodes_in_group("barrier")
		
		for barrier in barriers:
			var barrier_col = barrier.get_node("CollisionShape2D")
			var colliderSize = barrier_col.get_shape().get_rect().size
			if GlobalFunctions.collidesWithPoint(mouse_position, barrier.global_position, colliderSize):
				AudioHandler.play_player_SFX("res://SFX/player_shot2.wav")
				barrier.on_hit(self.atk * GameData.stat_bonus["player_bonuses"])
				is_ready = false
				timer.start()
				sprite_timer.start()
				Input.set_custom_mouse_cursor(shoting_cursor,Input.CURSOR_ARROW,Vector2(26.5, 26.5))
				return
		
		for shield in shields:
			var colliderSize = shield.get_shape().get_rect().size
			if GlobalFunctions.collidesWithPoint(mouse_position, shield.global_position, colliderSize):
				AudioHandler.play_player_SFX("res://SFX/player_shot2.wav")
				shield.on_hit(atk * GameData.stat_bonus["player_bonuses"])
				is_ready = false
				timer.start()
				sprite_timer.start()
				Input.set_custom_mouse_cursor(shoting_cursor,Input.CURSOR_ARROW,Vector2(26.5, 26.5))
				return
		
		for enemy in enemies:
			var colliderSize = enemy.get_child(1).get_shape().get_rect().size
		
			if GlobalFunctions.collidesWithPoint(mouse_position, enemy.position, colliderSize) and enemy.inmune == false:
				AudioHandler.play_player_SFX("res://SFX/player_shot2.wav")
				enemy.on_hit(self.atk * GameData.stat_bonus["player_bonuses"] , def_pen * GameData.stat_bonus["player_bonuses"])
				is_ready = false
				timer.start()
				sprite_timer.start()
				Input.set_custom_mouse_cursor(shoting_cursor,Input.CURSOR_ARROW,Vector2(26.5, 26.5))
				break

func _on_primary_cooldown_timeout():
	is_ready = true


func _on_sprite_timer_timeout():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(24.5, 24.5))
