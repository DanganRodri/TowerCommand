extends Label

@onready var turret = $"../../../../.."

func _ready():
	self.modulate = Color(1, 1, 1)

func _process(delta):
	self.text = str( roundi( turret.total_cost * 0.75 ) )


