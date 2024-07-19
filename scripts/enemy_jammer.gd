extends Enemy

class_name Jammer

@onready var shields = $Shields
var turret_jammed : Turret = null
var arrived = false

func _init():
	super._init("Jammer", 1, 0, 400, 300, true)

func find_turret():
	var turrets = get_tree().get_nodes_in_group("builded_turret")
	
	while(not turrets.is_empty()):
		var random_index = randi() % turrets.size()
		var random_turret = turrets[random_index]
		if  random_turret.stunned:
			turrets.erase(random_turret)
		else:
			turret_jammed = random_turret
			self.global_position[0] = random_turret.global_position[0]
			turret_jammed.stunned = true
			break

func _ready():
	randomize()
	self.position = Vector2(100000,50)
	find_turret()
	
	for shield in shields.get_children():
		shield.hp *= GameData.stat_bonus["endless_bonus"]
	
	damage_timer = Timer.new()
	damage_timer.wait_time = 0.035
	damage_timer.one_shot = true
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	add_child(damage_timer)

func on_hit(damage, def_pen):
	if not self.inmune:
		on_destroy()

func on_destroy():
	turret_jammed.stunned = false
	super.on_destroy()

func _physics_process(delta):
	if not turret_jammed == null and not arrived:
		global_position = global_position.move_toward(turret_jammed.global_position, self.speed * delta)
		if  global_position == turret_jammed.global_position:
			arrived = true

func _process(delta):
	if turret_jammed == null:
		find_turret()
	
	if shields.get_children().size() != 0:
		self.inmune = true
	else:
		on_destroy()
	
	if color == Color():
		color = sprite.modulate
	
	if not inmune:
		self.sprite.modulate = color
	
	apply_color_filter()
	
func status_effect(_effect,_duration,_value):
	return
