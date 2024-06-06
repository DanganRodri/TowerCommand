extends Area2D

class_name Barrier

var hp = 30


func on_hit(damage):
	hp -= damage
	if self.hp <= 0:
		on_destroy()

func on_destroy():
	position.x = 10000
	position.y = 10000
	self.hide()
