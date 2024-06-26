extends CollisionShape2D

class_name Shield

@onready var sprite_2d = $Sprite2D
var color : Color
var damaged : bool = false
var hp : float = 10.0
var damage_timer : Timer

func _ready():
	
	color = sprite_2d.modulate
	
	damage_timer = Timer.new()
	damage_timer.wait_time = 0.035
	damage_timer.one_shot = true
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	add_child(damage_timer)

func _process(delta):
	if self.damaged:
		sprite_2d.modulate = GameData.COLOR_DATA["STATUS"]["DAMAGED_COLOR"]
	else:
		sprite_2d.modulate = color

func on_hit(damage):
	hp -= damage
	damaged = true
	damage_timer.start()
	if self.hp <= 0:
		on_destroy()

func on_destroy():
	queue_free()

func _on_damage_timer_timeout():
	damaged = false
