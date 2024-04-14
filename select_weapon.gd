extends Control

@onready var main_game = load("res://game.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
