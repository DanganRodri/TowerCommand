extends Enemy

class_name Tank

func _init():
	super._init("Tank", 100, 2.0, 40, 100,false)
	

func _on_barrier_body_entered(body):
	if body is CharacterBody2D:
		body.protected.append(self.get_node("Barrier")) 


func _on_barrier_body_exited(body):
	if body is CharacterBody2D:
		body.protected.erase(self.get_node("Barrier"))
