extends Node

var main = null
var enemies = []

func _ready():
	main = get_tree().get_root()

func _process(delta):
	enemies = []
	var childs = get_children()
	
	for node in childs:
		if node is CharacterBody2D:
			enemies.append(node)
			
	
	

func get_all_enemies():
	if enemies.size() == 0:
		get_tree().change_scene_to_file("res://select_weapon.tscn")
	
	return enemies
