extends Node
# глобальная переменная она позже будет сохранятся здесь и загружаться куда надо
var save = "user://salty_kittens.save"
var mobile_control = false
var fullscreen = false
var vsinc = false
var max_fps = 144
var inventory = []
var TV = false
var v2 : Vector2

func _ready() -> void:
	load_game()
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if vsinc:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	Engine.max_fps = max_fps

func save_game():
	var file = FileAccess.open(save , FileAccess.WRITE)
	file.store_var(fullscreen)
	file.store_var(vsinc)
	file.store_var(max_fps)
	
func load_game():
	var file = FileAccess.open(save, FileAccess.READ)
	if !FileAccess.file_exists(save):
		save_game()
	else:
		fullscreen = file.get_var(fullscreen)
		vsinc = file.get_var(vsinc)
		max_fps = file.get_var(max_fps)
		
