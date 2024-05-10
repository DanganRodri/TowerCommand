extends Node

var main = null
var enemies = []
var basics = []
var tanks = []
var speedies = []
var towers = []
var gold : int = 0

var primaryWeapon: Weapon
var secondaryWeapon: Weapon

var level_parameters := {
	"primaryWeapon" = Weapon.new(),
	"secondaryWeapon" = Weapon.new()
}

func _ready():
	main = get_tree().get_root()

func _process(delta):
	
	enemies = []
	basics = []
	tanks = []
	speedies = []
	towers = []
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
		
		if primaryWeapon == null and node is Weapon:
			primaryWeapon = node as Weapon
	
		if secondaryWeapon == null and node is Weapon:
			secondaryWeapon = node as Weapon
			
		if node is StaticBody2D:
			towers.append(node)
			
		if node is Label:
			node.gold = self.gold
	

func get_all_enemies():
	if enemies.size() == 0:
		get_tree().change_scene_to_file("res://select_weapon.tscn")
	
	return enemies

func get_basic_enemies():
	return basics

func get_tank_enemies():
	return tanks

func get_speedy_enemies():
	return speedies

func get_towers():
	return towers
