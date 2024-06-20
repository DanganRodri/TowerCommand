extends TextureButton

class_name UpgradeNode

enum Effect {
	AddRange,
	AtkSpeed,
	Dmg,
	Poison,
	Slow,
	SlowDuration,
	AdvancedIce,
	Freeze,
	DpsIce,
	IceSkill,
	WIP
}

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line_2d = $Line2D
@onready var upgrade_effects = %UpgradeEffects
@onready var desc = %UpgradeDesc

@export var max_level : int = 3
@export var effect_id : Effect
@export var exclusive : bool = false

var effect : Callable = test
var selected : bool = false
var base_color : Color = self.modulate
var description : String = "ERROR: no desc availible."

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
	
	if selected == false:
		var upgradebuttons = get_tree().get_nodes_in_group("upgradebutton")
		
		for upb in upgradebuttons:
			upb.self_modulate = upb.base_color
			upb.selected = false
		
		self.selected = true
		self.self_modulate = Color(1, 1, 0.53333336114883)
		
		desc.text = description
		
		return
	
	else:
		if level == max_level:
			return
		
		level = min(level + 1, max_level)
		apply_effect()
		panel.hide()
		line_2d.default_color = Color(0.99999982118607, 0.94657629728317, 0.65052431821823)
		
		var childs = get_children()
		
		for child in childs:
			if child is UpgradeNode and level == 1:
				child.disabled = false
				child.panel.hide()
		
		if exclusive:
			var brothers = self.get_parent().get_children()
			
			for brother in brothers:
				if brother != self and brother is UpgradeNode:
					brother.disabled = true
					brother.panel.show()

func apply_effect():
	effect.call(self)

func test():
	print("efectivamente funciona")
