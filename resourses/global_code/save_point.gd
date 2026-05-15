extends Node
# глобальная переменная она позже будет сохранятся здесь и загружаться куда надо
var save = "user://salty_kittens.save"
var mobile_control = false
var fullscreen = false
var vsinc = false
var max_fps = 0
var inventory = []
var TV = false
var v2 : Vector2
var volume = {
	'Master':0,
	'music':0,
	'noise':0,
	'sound':0,
}

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
	for i in volume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i),volume[i])
## функия сохранения настроек, НЕ МЕНЯТЬ ПОРАДОК ЗАПИСИ БЛЯТЬ
func save_game():
	var file = FileAccess.open(save , FileAccess.WRITE)
	file.store_var(fullscreen)
	file.store_var(vsinc)
	file.store_var(max_fps)
	file.store_var(volume)
	file.close()

## функия загрузки настроек, НЕ МЕНЯТЬ ПОРАДОК ЧТЕНИЯ БЛЯТЬ
func load_game():
	if !FileAccess.file_exists(save):
		save_game()
	else:
		var file = FileAccess.open(save, FileAccess.READ)
		fullscreen = file.get_var()
		vsinc = file.get_var()
		max_fps = file.get_var()
		volume = file.get_var()
		file.close()
		
