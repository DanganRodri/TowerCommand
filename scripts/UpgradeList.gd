extends Panel

func _input(event):
	if self.visible and event is InputEventMouseButton  and event.pressed:
		var eventLocal = make_input_local(event)
		if !Rect2(Vector2(0, 0),self.size).has_point(eventLocal.position):
			self.visible = false
			var turret = get_parent().get_parent()
			turret.show_range = false
			turret.hide()
			turret.show()
			Engine.set_time_scale(turret.last_fastforward_speed)
		
