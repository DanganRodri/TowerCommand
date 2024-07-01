extends Node

var cursor = preload("res://assets/HUD/arrow_cursor.png")
var pressed_cursor = preload("res://assets/HUD/pressed_arrow_cursor.png")
var crosshair_cursor = preload("res://assets/HUD/cursor_big.png")
var on_menu : bool = true
var hover_cursor : bool = false

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_POINTING_HAND, Vector2(0, 0))

func pressed():
		if Input.is_action_pressed("left_click"):
			Input.set_custom_mouse_cursor(pressed_cursor, Input.CURSOR_ARROW, Vector2(0, 0))
		else:
			Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(0, 0))

func _process(delta):
	if on_menu:
		pressed()
	
	

func on_menu_enter():
	on_menu = true

func on_menu_exit():
	on_menu = false
	Input.set_custom_mouse_cursor(crosshair_cursor, Input.CURSOR_ARROW, Vector2(24.5, 24.5))
