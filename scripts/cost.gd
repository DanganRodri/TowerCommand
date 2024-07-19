extends Label

@onready var blank_turret = $"../../.."
@onready var turret = $"../../../../.."


func _process(delta):
	
	if blank_turret is BlankTurret:
		if blank_turret.cost > GameData.gold:
			self.modulate = Color(1, 0, 0)
		else:
			self.modulate = Color(1, 1, 1)
		self.text = str( blank_turret.cost )
	else:
		if turret.cost * GameData.stat_bonus["turret_discount"] > GameData.gold :
			self.modulate = Color(1, 0, 0)
		else:
			self.modulate = Color(1, 1, 1)
		self.text = str(  roundi( turret.cost * GameData.stat_bonus["turret_discount"] ) )

