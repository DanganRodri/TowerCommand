extends CollisionShape2D

class_name Barrier

var hp = 10

func _process(delta):
	
	if hp <= 0:
		self.queue_free()
		pass
