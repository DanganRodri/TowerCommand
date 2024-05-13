extends StaticBody2D

class_name Turret

#Stats of the tower

var map_node
var enemy_in_sight = []
var target : Enemy = null
var show_range : bool = true

var atk : int = 1
var atk_speed : float = 0.4
var def_pen : int = 0
var range : float = 0.0
var reloading : bool = false
var defending_tower : Tower = null


func _ready():
	if not self is BlankTurret:
		self.get_node("Range/CollisionShape2D").get_shape().radius = range
		select_tower_to_defend()
	

func _draw():
	if self.show_range:
		var center = Vector2(0,0)
		var radius = self.range
		var color = Game.RANGE_BORDER_COLOR
		draw_circle(center, radius, color)
		
		radius -= 4.5
		color = Game.RANGE_COLOR
		draw_circle(center, radius, color)

func _physics_process(delta):
	if not self is BlankTurret and target == null:
		select_enemy()
	if target != null:
		turn()
		if not reloading:
			fire()
	

func select_tower_to_defend():
	var towers = self.get_parent().get_parent().get_node("Towers").get_children()
	defending_tower = Game.check_closest(self, towers)

func select_enemy():
	target = Game.check_closest(defending_tower, enemy_in_sight)

func turn():
	self.look_at(target.position)
	
func fire():
	reloading = true
	target.on_hit(atk)
	await get_tree().create_timer(atk_speed).timeout
	reloading = false

func _on_range_body_entered(body):
	if body is CharacterBody2D and not body.inmune:
		enemy_in_sight.append(body)

func _on_range_body_exited(body):
	enemy_in_sight.erase(body)
