extends CollisionShape2D


func _draw():
	var center = Vector2(0,0)
	var radius = self.shape.radius
	var color = GameData.COLOR_DATA["RANGE"]["BARRIER_RANGE_BORDER_COLOR"]
	draw_circle(center, radius, color)
	
	radius -= 4.5
	color = GameData.COLOR_DATA["RANGE"]["BARRIER_RANGE_COLOR"]
	draw_circle(center, radius, color)
