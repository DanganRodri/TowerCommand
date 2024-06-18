extends Button

@onready var timer_progress = $TextureProgressBar
@onready var skill_cd = $Skill_CD

var go_on_cd = true
var on_cd = false

func _ready():
	timer_progress.max_value = skill_cd.wait_time

func _process(delta):
	if go_on_cd:
		on_cd = true
		go_on_cd = false
		skill_cd.start()
		timer_progress.show()
	
	if on_cd:
		timer_progress.value = skill_cd.wait_time - skill_cd.time_left


func _on_skill_cd_timeout():
	self.disabled = false
	timer_progress.hide()
