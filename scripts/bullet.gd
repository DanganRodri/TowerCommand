extends CharacterBody2D

class_name Bullet

var speed : float = 400.0
var target : Enemy = null
var target_pos : Vector2 = Vector2(-1,-1)
var atk : float = 0.0
var def_pen : float = 0.0
var status_effect : String = "none"
var status_duration : float = 0.0
var status_value : float = 0.0
var on_area : bool = false
var explosion_radius : float = 0.0

func _physics_process(delta):
	if target != null:
		target_pos = target.global_position
		self.global_position =  global_position.move_toward(target_pos, self.speed * delta)
	elif target_pos != Vector2(-1,-1):
		self.global_position =  global_position.move_toward(target_pos, self.speed * delta)
	if target_pos == self.global_position:
		if on_area and not status_effect == "poison":
			area_hit()
		if on_area and status_effect == "poison":
			if target != null:
				target.on_hit(atk, def_pen)
			area_hit()
		if target != null and not on_area:
			target.on_hit(atk, def_pen)
			target.status_effect(status_effect,status_duration,status_value)
		self.queue_free()

func area_hit():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var shape = CircleShape2D.new()
	shape.radius = explosion_radius
	query.shape = shape
	query.transform.origin = target_pos

	var result = space_state.intersect_shape(query)
	
	for enemy in result:
		if enemy.collider and enemy.collider.is_in_group("enemy"):
			if status_effect != "poison":
				enemy.collider.on_hit(atk, self.def_pen)
			if not enemy.collider.stealth:
				enemy.collider.status_effect(status_effect,status_duration,status_value)
