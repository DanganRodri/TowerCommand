extends TextureButton

class_name UpgradeNode



enum Effect {
	AddRange,
	AddAtkSpeed,
	AddDmg
}

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line_2d = $Line2D
@onready var upgrade_effects = %UpgradeEffects


@export var max_level : int = 3
@export var effect_id : Effect

var effect : Callable = test

var level : int = 0:
	set(value):
		level = value
		if max_level > 1:
			label.text = str(level) + "/" + str(max_level)
	

func _ready():
	upgrade_effects.set_effect(self)
	
	if max_level > 1:
		label.text = str(level) + "/" + str(max_level)
	if get_parent() is UpgradeNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
	else:
		panel.hide()
		
		
func _on_pressed():
	if level == max_level:
		return
	
	apply_effect()
	level = min(level + 1, max_level)
	panel.hide()
	line_2d.default_color = Color(0.99999982118607, 0.94657629728317, 0.65052431821823)
	
	var childs = get_children()
	
	for child in childs:
		if child is UpgradeNode and level >= 1:
			child.disabled = false
			child.panel.hide()

func apply_effect():
	effect.call()

func test():
	print("efectivamente funciona")
