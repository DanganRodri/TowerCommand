extends Node

@onready var music = $Music
@onready var sfx = $SFX

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

func _on_music_finished():
	var stream = load(s)
	music.set_stream(stream)
	music.play()
