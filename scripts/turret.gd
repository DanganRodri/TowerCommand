extends StaticBody2D

class_name Turret

#Stats of the tower

var map_node
var enemy_in_sight = []

var atk_speed : float = 0.0
var damage : int = 0
var def_pen : int = 0
var range : float = 170.0


func _ready():
	if not self is BlankTurret:
		self.get_node("Range/CollisionShape2D").get_shape().radius = range
	


func _on_range_body_entered(body):
	if body is CharacterBody2D:
		enemy_in_sight.append(body)
		print(enemy_in_sight)

func _on_range_body_exited(body):
	enemy_in_sight.erase(body)
