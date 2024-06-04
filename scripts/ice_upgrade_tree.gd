extends Control

class_name UpgradeTree

func set_effect(upgrade : UpgradeNode):
	var effect = upgrade.effect_id
	match(effect):
		UpgradeNode.Effect.AddRange:
			upgrade.effect = add_range
		UpgradeNode.Effect.AddAtkSpeed:
			upgrade.effect = add_atkspeed
		UpgradeNode.Effect.AddDmg:
			upgrade.effect = add_damage



func add_range():
	print("rango incrementado")

func add_atkspeed():
	print("velocidad de ataque incrementado")

func add_damage():
	print("daño incrementado")
