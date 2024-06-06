extends Node

var main = null
var enemies = []
var basics = []
var tanks = []
var speedies = []
var gold : int = GameData.MAX_GOLD
var spawnManager

var primaryWeapon: Weapon


var level_parameters := {
	"primaryWeapon" = Weapon.new(),
}

func _ready():
	main = get_tree().get_root()
	spawnManager = get_node("SpawnPoints")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _process(delta):
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	enemies = []
	basics = []
	tanks = []
	speedies = []
	var childs = get_children()
	
	var goldLabel = get_node("UI/HUD/Gold")
	if goldLabel:
		goldLabel.gold = self.gold
	
	for node in childs:
		if node is CharacterBody2D:
			enemies.append(node)
			if node is Basic:
				basics.append(node)
			if node is Tank:
				tanks.append(node)
			if node is Speedy:
				speedies.append(node)
					
		if primaryWeapon == null and node is Weapon:
			primaryWeapon = node as Weapon
	
	

func get_all_enemies():
	if enemies.size() == 0 and spawnManager.last_wave:
		get_tree().change_scene_to_file("res://select_weapon.tscn")
	
	return enemies

func get_basic_enemies():
	return basics

func get_tank_enemies():
	return tanks

func get_speedy_enemies():
	return speedies
