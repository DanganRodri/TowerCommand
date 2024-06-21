extends Turret

class_name AdvancedIceTurret

var freeze_wave = false
var freeze_timer : Timer

func _ready():
	atk = 4
	atk_speed = 1.9
	def_pen = 0
	range = 155.0 * GameData.stat_bonus["range_ice"]
	attack_frame = 4
	super._ready()


func fire():
	animated_sprite_2d.play("shoot")

func apply_attack():
	reloading = true
	for enemy in enemy_in_sight:
		enemy.on_hit(atk)
		enemy.status_effect("slow", GameData.BASE_SLOW_DURATION , GameData.BASE_SLOW)
	reload_timer.start()

func freeze():
	animated_sprite_2d.play("shoot")
	for enemy in enemy_in_sight:
		enemy.on_hit(atk)
		enemy.status_effect("freeze", GameData.BASE_FREEZE_DURATION , 0)
	freeze_wave = false
	freeze_timer.start()

func _physics_process(delta):
	if not enemy_in_sight.is_empty():
		if not reloading and animated_sprite_2d.animation == "default":
			fire()
		if not reloading and animated_sprite_2d.animation == "shoot" and animated_sprite_2d.frame == attack_frame:
			apply_attack()
		if freeze_wave:
			freeze()

func _on_freeze_timer():
	freeze_wave = true
