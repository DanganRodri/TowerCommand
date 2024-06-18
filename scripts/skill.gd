extends Area2D

class_name Skill

var skill_mode = true
var enemy_in_area = []
var damage = 1
@onready var skill_timer = $Skill_timer
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	skill_timer.start()
	collision_shape_2d.shape.radius = 100
	
func _process(delta):
	if skill_mode:
		global_position = get_global_mouse_position()
		Engine.set_time_scale(GameData.SLOWMOTION)
	else:
		skill_effect()

func _input(event):
	if event.is_action_pressed("left_click") and skill_mode:
		skill_mode = false
		Engine.set_time_scale(GameData.FASTFORWARD_STAGES[GameData.fastforward_actual_stage])
		get_parent().disabled = true
		get_parent().go_on_cd = true
	
	if event.is_action_pressed("right_click") and skill_mode:
		skill_mode = false
		Engine.set_time_scale(GameData.FASTFORWARD_STAGES[GameData.fastforward_actual_stage])
		queue_free()

func skill_effect():
	pass

func _on_skill_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is CharacterBody2D and not body.inmune:
		enemy_in_area.append(body)


func _on_body_exited(body):
	enemy_in_area.erase(body)
