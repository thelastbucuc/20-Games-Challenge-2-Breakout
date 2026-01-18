extends Node


const SOUND_BOUNCE: String = "bounce"
const SOUND_POINT: String = "point"
const SOUND_WIN: String = "win"
const SOUND_GAME_OVER: String = "game_over"
const SOUND_HURT: String = "hurt"
const SOUND_UI_BUTTON: String = "ui_button"
const SOUND_LAUNCH: String = "launch"


const SOUNDS: Dictionary[String, AudioStream] = {
	SOUND_BOUNCE: preload("uid://dxvxg4pqy0237"),
	SOUND_POINT: preload("uid://byvo5ph8m4ap3"),
	SOUND_WIN: preload("uid://dh4r3ckwwgyuf"),
	SOUND_GAME_OVER: preload("uid://qcapd6r4lw7q"),
	SOUND_HURT: preload("uid://0csrug7ltoe5"),
	SOUND_UI_BUTTON: preload("uid://tkwvmkj2sacg"),
	SOUND_LAUNCH: preload("uid://c16gia783t8ly")
}


func play_sound(player: AudioStreamPlayer2D, key: String) -> void:
	if SOUNDS.has(key) == false:
		return
	
	player.stop()
	player.stream = SOUNDS[key]
	player.play()
