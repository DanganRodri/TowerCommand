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

func check_closest_exclusive(entity, exclude, entity_array):
	
	var min_distance = INF
	var closest = null
	
	for e in entity_array:
		if e == exclude:
			continue
		var distance = calculate_distance(entity, e)
		if distance < min_distance:
			min_distance = distance
			closest = e
	
	return closest

func collidesWithPoint(point, pos, size):
	
	if point.x >= pos.x - size[0]/2 and point.x <= pos.x + size[0]/2: # la posición del personaje está centrica al objeto, no en la esquina superior izquierda
		if point.y >= pos.y - size[1]/2 and point.y <= pos.y + size[1]/2:
			return true
	
	return false

func calculate_distance(e1, e2):
	return e1.position.distance_to(e2.position)
