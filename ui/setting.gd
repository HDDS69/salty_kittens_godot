extends Control
@onready var sound_click = $"../sound/click"
var fullscreen = false

func _on_quit_setting_pressed():
	self.hide()

func _on_full_screen_pressed():
	fullscreen = !fullscreen
	sound_click.play()
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_controll_pressed() -> void:
	sound_click.play()
