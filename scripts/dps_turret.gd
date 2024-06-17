extends Turret

class_name DpsTurret
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	atk = 10
	atk_speed = 0.75
	def_pen = 7
	range = 170.0
	super._ready()

func fire():
	reloading = true
	turn()
	target.on_hit(atk)
	animated_sprite_2d.play("shoot")
	await get_tree().create_timer(atk_speed).timeout
	reloading = false

