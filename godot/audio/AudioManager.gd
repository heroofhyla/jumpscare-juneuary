extends Node2D

const music_path := "res://audio/music/"
const sfx_path := "res://audio/sfx/"
var sfx_volume = 100
var music_volume = 100
var audio_persist = Persistence.audio


func _ready():
	sync_volume()


func play_music(track_name: String):
	$MusicPlayer.play(load("res://audio/music/%s.ogg" % track_name))


func stop_music():
	$MusicPlayer.stop()


func play_sfx(track_name: String, randomize_pitch:=false):
	$SFXPlayer.play(load("res://audio/sfx/%s.ogg" % track_name), randomize_pitch)


func music_bpm_offset() -> float:
	return $MusicPlayer.bpm_offset()


func _process(_delta):
	sync_volume()


func sync_volume():
	if audio_persist.sfx_volume != sfx_volume:
		sfx_volume = audio_persist.sfx_volume
		$SFXPlayer.volume_linear = sfx_volume / 100.0
	if audio_persist.music_volume != music_volume:
		music_volume = audio_persist.music_volume
		$MusicPlayer.volume_linear = music_volume / 100.0
