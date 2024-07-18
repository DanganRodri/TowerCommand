extends Node

@onready var goldLabel = %Gold
var crosshair_cursor = preload("res://assets/HUD/cursor_big.png")

var main = null
var enemies = []
var basics = []
var tanks = []
var speedies = []
var gold : int =  GameData.MAX_GOLD
var spawnManager

func _ready():
	main = get_tree().get_root()
	spawnManager = get_node("SpawnPoints")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _process(delta):
	enemies = []
	basics = []
	tanks = []
	speedies = []
	var childs = get_children()
	
	for node in childs:
		if node is CharacterBody2D:
			enemies.append(node)
			if node is Basic:
				basics.append(node)
			if node is Tank:
				tanks.append(node)
			if node is Speedy:
				speedies.append(node)
				
func get_all_enemies():
	if enemies.size() == 0 and spawnManager.last_wave:
		get_tree().change_scene_to_file("res://scenes/menu_handler.tscn")
	
	return enemies

func get_basic_enemies():
	return basics

func get_tank_enemies():
	return tanks

func get_speedy_enemies():
	return speedies

