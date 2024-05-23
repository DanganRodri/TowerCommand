extends Control


@onready var main_game = load("res://game.tscn")

@onready var weapon_container1 = get_node("./HBoxContainer/VBoxContainer")
@onready var weapon_container2 = get_node("./HBoxContainer/VBoxContainer2")
@onready var weapon_container3 = get_node("./HBoxContainer/VBoxContainer3")

var first_enter = true

var primaryWeapon: Weapon
var secondaryWeapon: Weapon

var level_parameters := {
	"primaryWeapon" = Weapon.new(),
	"secondaryWeapon" = Weapon.new()
}

func _on_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func generate_weapon(weapon_container):
	var randomWeapon = Weapon.new()
	var randomType = randi() % 3
	
	var AR = randomWeapon.weapon_type.AR
	var SG = randomWeapon.weapon_type.SG
	var RL = randomWeapon.weapon_type.RL
	
	
	match randomType:
		AR:
			randomWeapon.type = randomWeapon.weapon_type.AR
		SG:
			randomWeapon.type = randomWeapon.weapon_type.SG
		RL:
			randomWeapon.type = randomWeapon.weapon_type.RL
	
	var randomAtKSpeed = 0
	
	match randomType:
		AR:
			randomWeapon.atk_speed = floor((randf() * WeaponRules.max_AR_atkSpeed + WeaponRules.min_AR_atkSpeed) * 100) / 100
		SG:
			randomWeapon.atk_speed = floor((randf() * WeaponRules.max_SG_atkSpeed + WeaponRules.min_SG_atkSpeed) * 100) / 100
		RL:
			randomWeapon.atk_speed = floor((randf() * WeaponRules.max_RL_atkSpeed + WeaponRules.min_RL_atkSpeed) * 100) / 100
	
	var randomDamage = 0
	
	match randomType:
		AR:
			randomWeapon.damage = randf() * WeaponRules.max_AR_damage + WeaponRules.min_AR_damage
		SG:
			randomWeapon.damage = randf() * WeaponRules.max_SG_damage + WeaponRules.min_SG_damage
		RL:
			randomWeapon.damage = randf() * WeaponRules.max_RL_damage + WeaponRules.min_RL_damage
	
	var text = weapon_container.get_child(1)
	text.bbcode_text = "Type: " + str(randomWeapon.type) + "\n" + "Atk. Speed: " + str(randomWeapon.atk_speed) + "\n" + "Damage: " + str(randomWeapon.damage) + "\n" + "Cost: 200" + "\n"

func generate_weapons():
	generate_weapon(weapon_container1)
	generate_weapon(weapon_container2)
	generate_weapon(weapon_container3)

func _process(delta):
	if first_enter:
		generate_weapons()
		first_enter = false
	pass
