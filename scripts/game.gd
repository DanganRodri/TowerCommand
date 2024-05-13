extends Node

var main = null
var enemies = []
var basics = []
var tanks = []
var speedies = []
var towers = []
var gold : int = 0

const RANGE_BORDER_COLOR = Color(0.2, 0.5, 1, 0.77)
const RANGE_COLOR = Color(0, 0, 0, 0.1)

var primaryWeapon: Weapon


var level_parameters := {
	"primaryWeapon" = Weapon.new(),
}

func _ready():
	main = get_tree().get_root()
	towers = Tower_Manager.get_children()

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
		
		if node is Label:
			node.gold = self.gold
			

func check_closest(entity, entity_array):
	
	var min_distance = INF
	var closest = null
	
	for e in entity_array:
		var distance = calculate_distance(entity, e)
		if distance < min_distance:
			min_distance = distance
			closest = e
	
	return closest
	
func calculate_distance(e1, e2):
	return e1.position.distance_to(e2.position)

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
