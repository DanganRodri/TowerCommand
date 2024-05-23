extends CollisionShape2D


func _draw():
	var center = Vector2(0,0)
	var radius = self.shape.radius
	var color = Game.RANGE_BORDER_COLOR
	draw_circle(center, radius, color)
	
	radius -= 4.5
	color = Game.RANGE_COLOR
	draw_circle(center, radius, color)
