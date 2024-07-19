extends StaticBody2D

class_name Tower
@onready var pause_panel = $"../../UI/PausePanel"
@onready var back_ground = $"../../UI/PausePanel/BackGround"
@onready var end_screen = $"../../UI/PausePanel/EndScreen"


func _on_area_2d_body_entered(enemy):
	if enemy is Enemy:
		GameData.health -= 1
		if enemy is Boss:
			GameData.health = 0
		enemy.queue_free()
		if GameData.health <= 0:
			GameData.game_ended = true
			AudioHandler.play_SFX("res://SFX/game_over.wav")
			pause_panel.show()
			back_ground.hide()
			end_screen.show()
			get_tree().paused = true
