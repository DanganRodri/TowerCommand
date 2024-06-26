extends Turret

class_name AdvancedAoeTurret

var burn_wave = false
var burn_timer : Timer

func _ready():
	atk = 12
	atk_speed = 1.7
	def_pen = 10
	range = 160.0
	attack_frame = 4
	super._ready()


func fire():
	animated_sprite_2d.play("shoot")

func apply_attack():
	reloading = true
	for enemy in enemy_in_sight:
		enemy.on_hit(atk * GameData.stat_bonus["atk_aoe"], def_pen)
	reload_timer.start()

func burn():
	animated_sprite_2d.play("shoot")
	for enemy in enemy_in_sight:
		enemy.on_hit(atk * 0.3 * GameData.stat_bonus["atk_aoe"], 100)
		enemy.status_effect("burn", GameData.BASE_BURN_DURATION , 0)
	burn_wave = false
	burn_timer.start()

func _physics_process(delta):
	if self.stunned:
			return
	if not enemy_in_sight.is_empty():
		if not reloading and animated_sprite_2d.animation == "default":
			fire()
		if not reloading and animated_sprite_2d.animation == "shoot" and animated_sprite_2d.frame == attack_frame:
			apply_attack()
		if burn_wave:
			burn()

func _on_burn_timer():
	burn_wave = true

