extends Bullet

class_name GlobalSniperBullet

var direction : Vector2 = Vector2(-100, -100)

func _physics_process(delta):
	
	if direction == Vector2(-100, -100):
		direction = (target_pos - global_position).normalized()
		self.look_at(target_pos)
	
	if direction != Vector2(-100, -100):
		#self.global_position =  global_position.move_toward(target_pos, (self.speed * 2.25) * delta)
		var distance = speed * delta
		global_position += direction * distance
		
	if self.global_position[0] > 1000 or self.global_position[1] > 1000:
		self.queue_free()


func _on_area_2d_body_entered(enemy):
	if enemy is Enemy:
		enemy.on_hit(self.atk,self.def_pen)
