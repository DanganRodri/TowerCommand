extends ProgressBar

func _ready():
	self.max_value = get_parent().hp
	self.visible = false
	
func _process(delta):
	if self.max_value != self.value:
		self.visible = true
	self.value = get_parent().hp
