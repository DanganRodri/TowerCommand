extends Node

func check_closest(entity, entity_array):
	
	var min_distance = INF
	var closest = null
	
	for e in entity_array:
		var distance = calculate_distance(entity, e)
		if distance < min_distance:
			min_distance = distance
			closest = e
	
	return closest

func calculate_distance(e1, e2):
	return e1.position.distance_to(e2.position)
