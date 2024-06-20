extends StaticBody2D

class_name Turret
@onready var animated_sprite_2d = $AnimatedSprite2D
#Stats of the tower

var map_node
var enemy_in_sight = []
var target : Enemy = null
var show_range : bool = false
var last_fastforward_speed = 1

var level : int = 1
var atk : int = 1
var atk_speed : float = 0.4
var def_pen : int = 0
var range : float = 0.0
var reloading : bool = false
var defending_tower : Tower = null
var cost : int = 200
var total_cost : int = cost

var reload_timer : Timer
var attack_frame : int = 4


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var upgradeList = get_node("Upgrade/UpgradeList")
		upgradeList.visible = !upgradeList.visible
		upgradeList.global_position = self.position + Vector2(-115, 28)
		last_fastforward_speed = Engine.get_time_scale()
		Engine.set_time_scale(GameData.SLOWMOTION)
		self.show_range = true
		hide()
		show()

func _ready():
	if not self is BlankTurret:
		self.get_node("Range/CollisionShape2D").get_shape().radius = range
		select_tower_to_defend()
		self.cost = 150
		
		reload_timer = Timer.new()
		reload_timer.wait_time = self.atk_speed
		reload_timer.one_shot = true
		reload_timer.connect("timeout", Callable(self, "_on_reload_timer"))
		add_child(reload_timer)
	

func _draw():
	if self.show_range:
		var center = Vector2(0,0)
		var radius = self.range
		var color = GameData.COLOR_DATA["RANGE"]["TURRET_RANGE_BORDER_COLOR"]
		draw_circle(center, radius, color)
			
		radius -= 4.5
		color = GameData.COLOR_DATA["RANGE"]["TURRET_RANGE_COLOR"]
		draw_circle(center, radius, color)

func _physics_process(delta):
	if not self is BlankTurret and target == null:
		select_enemy()
	if target != null and not reloading:
		if  animated_sprite_2d.animation == "default":
			fire()
		if animated_sprite_2d.animation == "shoot" and animated_sprite_2d.frame == attack_frame:
			apply_attack()

func select_tower_to_defend():
	var towers = self.get_parent().get_parent().get_node("Towers").get_children()
	defending_tower = GlobalFunctions.check_closest(self, towers)

func select_enemy():
	target = GlobalFunctions.check_closest(defending_tower, enemy_in_sight)

func turn():
	self.look_at(target.position)
	
func fire():
	turn()
	animated_sprite_2d.play("shoot")
	
func apply_attack():
	reloading = true
	target.on_hit(atk)
	reload_timer.start()

func _on_range_body_entered(body):
	if body is CharacterBody2D and not body.inmune:
		enemy_in_sight.append(body)

func _on_range_body_exited(body):
	target = null
	enemy_in_sight.erase(body)

func _on_upgrade_pressed():
	var root = get_parent().get_parent()
	if root.gold >= self.cost:
		root.gold = root.gold - self.cost
		self.level = self.level + 1
		self.total_cost = self.total_cost + self.cost
		self.cost = self.cost + (self.cost * 0.6)
		self.atk = self.atk + (self.atk * 0.2)
		self.atk_speed = self.atk_speed - (self.atk_speed * 0.05)
		self.def_pen = self.def_pen + (self.def_pen * 0.2)
		self.range = self.range + (self.range * 0.025)
		self.get_node("Range/CollisionShape2D").get_shape().radius = range
		hide()
		show()

func _on_discard_pressed():
	var root = get_parent().get_parent()
	root.gold = root.gold + (self.total_cost * 0.75)
	var new_turret = load("res://entities/turret.tscn").instantiate()
	var root_node = get_parent().get_parent()
	root_node.get_node("Turrets").add_child(new_turret)
	new_turret.global_position = global_position
	Engine.set_time_scale(last_fastforward_speed)
	queue_free()

func _on_reload_timer():
	reloading = false
