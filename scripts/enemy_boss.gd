extends Enemy

class_name Boss

@onready var inmune_timer = $InmuneTimer
@onready var inmune_cd = $InmuneCD

func _init():
	super._init("Boss", 300, 3.0, 40, 150,false)


func _on_inmune_timer_timeout():
	inmune = false
	self.sprite.modulate = color
	inmune_cd.start()

func _on_inmune_cd_timeout():
	inmune = true
	slowed = false
	burned = false
	poisoned = false
	inmune_timer.start()
