extends Node

@onready var play_button = get_node("MainMenu/MarginContainer/VBoxContainer/VBoxContainer/PlayButton")
@onready var exit_button = get_node("MainMenu/MarginContainer/VBoxContainer/VBoxContainer/ExitButton")

func _ready():
	AudioHandler.play_song("res://music/MenuTheme.mp3")
	play_button.connect("pressed", Callable( self, "on_play_pressed"))
	exit_button.connect("pressed", Callable( self, "on_exit_pressed"))
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func on_play_pressed():
	AudioHandler.play_SFX("res://SFX/button_pressed.wav")
	get_node("MainMenu").hide()
	get_node("LevelMenu").show()
	
func on_exit_pressed():
	get_tree().quit()
