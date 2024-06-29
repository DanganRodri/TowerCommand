extends Label
@onready var unpause_timer = $"../UnpauseTimer"

func _process(delta):
	if not unpause_timer.is_stopped():
		self.text = str(ceil( unpause_timer.time_left) )
