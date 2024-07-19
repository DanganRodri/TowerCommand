extends Node

@onready var music = $Music
@onready var sfx = $SFX
@onready var player_sfx = $player_SFX

var s : String

func play_song(path : String):
	var stream = load(path)
	s = path
	music.set_stream(stream)
	music.play()

func play_SFX(path : String):
	var stream = load(path)
	sfx.set_stream(stream)
	sfx.play()

func play_player_SFX(path : String):
	var stream = load(path)
	player_sfx.set_stream(stream)
	player_sfx.play()

func _on_music_finished():
	var stream = load(s)
	music.set_stream(stream)
	music.play()
