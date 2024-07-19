extends Label
@onready var turret = $"../../.."


func _process(delta):
	text = "Level: " + str (turret.level)
