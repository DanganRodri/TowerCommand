extends StaticBody2D

class_name Turret
@onready var animated_sprite_2d = $AnimatedSprite2D
var color : Color = Color()

var cursor = preload("res://assets/HUD/arrow_cursor.png")
var crosshair_cursor = preload("res://assets/HUD/cursor_big.png")
#Stats of the tower

var map_node
var enemy_in_sight = []
var target : Enemy = null
var show_range : bool = false
var last_fastforward_speed = 1

var level : int = 1
var atk : int = 1
var atk_speed : float = 0.4
var def_pen : float = 0.0
var range : float = 0.0
var reloading : bool = false
var defending_tower : Tower = null
var cost : int = 200
var total_cost : int = cost

var reload_timer : Timer
var attack_frame : int = 4
var stunned : bool = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1 and not self.stunned:
		var upgradeList = get_node("Upgrade/UpgradeList")
		upgradeList.visible = !upgradeList.visible
		upgradeList.global_position = self.position + Vector2(-115, 28)
		last_fastforward_speed = Engine.get_time_scale()
		Engine.set_time_scale(GameData.SLOWMOTION)
		self.show_range = true
		hide()
		show()

func _ready():
	
	color = animated_sprite_2d.modulate
	
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
		if self.is_in_group("aoe"):
			radius = self.range * GameData.stat_bonus["range_aoe"]
		if self.is_in_group("ice"):
			radius = self.range * GameData.stat_bonus["range_ice"]
		if self.is_in_group("sniper"):
			radius = self.range * GameData.stat_bonus["range_sniper"]
			
		var color = GameData.COLOR_DATA["RANGE"]["TURRET_RANGE_BORDER_COLOR"]
		draw_circle(center, radius, color)
			
		radius -= 4.5
		color = GameData.COLOR_DATA["RANGE"]["TURRET_RANGE_COLOR"]
		draw_circle(center, radius, color)


func mouse_hover():
	var mouse_position = get_global_mouse_position()
	var colliderSize = self.get_node("CollisionShape2D").get_shape().get_rect().size
	
	if GlobalFunctions.collidesWithPoint(mouse_position, self.global_position, colliderSize):
		Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(0, 0))
		CursorManager.hover_cursor = true
	else:
		Input.set_custom_mouse_cursor(crosshair_cursor, Input.CURSOR_ARROW, Vector2(0, 0))

func _process(delta):
	if not self is BlankTurret:
		if self.is_in_group("aoe"):
			self.get_node("Range/CollisionShape2D").get_shape().radius = range * GameData.stat_bonus["range_aoe"]
		if self.is_in_group("ice"):
			self.get_node("Range/CollisionShape2D").get_shape().radius = range * GameData.stat_bonus["range_ice"]
		if self.is_in_group("sniper"):
			self.get_node("Range/CollisionShape2D").get_shape().radius = range * GameData.stat_bonus["range_sniper"]
	
		if self.stunned:
			animated_sprite_2d.modulate = GameData.COLOR_DATA["STATUS"]["STUN_COLOR"]
		else:
			animated_sprite_2d.modulate = color

func _physics_process(delta):
	if self.stunned:
			return
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
	target.on_hit(atk, def_pen)
	reload_timer.start()

func _on_range_body_entered(body):
	if body is CharacterBody2D and not body.stealth:
		enemy_in_sight.append(body)

func _on_range_body_exited(body):
	target = null
	enemy_in_sight.erase(body)

func _on_upgrade_pressed():
	if GameData.gold >= self.cost * GameData.stat_bonus["turret_discount"]:
		GameData.gold -= self.cost * GameData.stat_bonus["turret_discount"]
		self.level = self.level + 1
		self.total_cost = self.total_cost + (self.cost * GameData.stat_bonus["turret_discount"])
		self.cost = self.cost + (self.cost * 0.35)
		self.atk = self.atk + (self.atk * 0.2)
		self.atk_speed = self.atk_speed - (self.atk_speed * 0.05)
		self.def_pen = min(self.def_pen + (self.def_pen * 0.2), 100.0)
		self.range = self.range + (self.range * 0.025)
		self.get_node("Range/CollisionShape2D").get_shape().radius = range
		hide()
		show()

func _on_discard_pressed():
	GameData.gold = min(GameData.MAX_GOLD , GameData.gold + (self.total_cost * 0.75))
	var new_turret = load("res://entities/turret.tscn").instantiate()
	var root_node = get_parent().get_parent()
	root_node.get_node("Turrets").add_child(new_turret)
	new_turret.global_position = global_position
	Engine.set_time_scale(last_fastforward_speed)
	queue_free()

func _on_reload_timer():
	reloading = false
	
	if self.is_in_group("dps"):
		reload_timer.wait_time = self.atk_speed / GameData.stat_bonus["atk_speed_dps"]
	
	if self.is_in_group("aoe"):
		reload_timer.wait_time = self.atk_speed / GameData.stat_bonus["atk_speed_aoe"]
	
	if self.is_in_group("ice"):
		reload_timer.wait_time = self.atk_speed / GameData.stat_bonus["atk_speed_ice"]
	
	if self.is_in_group("sniper"):
		reload_timer.wait_time = self.atk_speed / GameData.stat_bonus["atk_speed_sniper"]
