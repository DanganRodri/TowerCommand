extends Turret

class_name AdvancedIceTurret

var freeze_wave = false
var freeze_timer : Timer

func _ready():
	atk = 4
	atk_speed = 1.9
	def_pen = 0
	range = 155.0
	super._ready()


func fire():
	reloading = true
	animated_sprite_2d.play("shoot")
	for enemy in enemy_in_sight:
		enemy.on_hit(atk)
		enemy.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
	await get_tree().create_timer(atk_speed).timeout
	reloading = false

func freeze():
	animated_sprite_2d.play("shoot")
	for enemy in enemy_in_sight:
		enemy.on_hit(atk)
		enemy.status_effect("freeze", GameData.BASE_FREEZE_DURATION , 0)
	freeze_wave = false
	freeze_timer.start()

func _physics_process(delta):
	if not enemy_in_sight.is_empty():
		if not reloading:
			fire()
		if freeze_wave:
			freeze()

func _on_freeze_timer():
	freeze_wave = true
