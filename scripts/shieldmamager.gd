extends Area2D

func reactive_shields():
	for shield in get_children():
		shield.disabled = false

func check_order(shield_hitted):
	var shields = get_children()
	var min = true
	var number_hitted = shield_hitted.number
	
	for shield in shields:
		if not shield.disabled:
			var number = shield.number
			if number_hitted > number:
				min = false
	
	if min == true:
		shield_hitted.disabled = true
	else:
		reactive_shields()
	
	shield_hitted.hitted = true

func check_if_shields_down():
	for shield in get_children():
		if shield.disabled == false:
			return false
	
	return true

func _ready():
	var i = 1
	for shield in get_children():
		shield.number = i
		i = i + 1

func _process(delta):
	
	for shield in get_children():
		shield = shield as Shield
		if shield.hitted:
			check_order(shield)
	
	if check_if_shields_down():
		get_parent().inmune = false
