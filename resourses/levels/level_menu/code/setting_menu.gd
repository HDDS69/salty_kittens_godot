extends Node2D

@onready var grf_set = $setting/graphics_button/graphics
@onready var msc_set = $setting/music_set/music_list
func _on_quit_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://resourses/levels/level_menu/code/menu_new.tscn")

func change_volume(txt,value,buss):
	txt.text  = str(int((value + 80)/80 * 100))+"%"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(buss),value)
	
func _on_graphics_button_pressed() -> void:
	grf_set.show()
	msc_set.hide()


func _on_check_box_2_pressed() -> void:
	SavePoint.fullscreen = !SavePoint.fullscreen
	if SavePoint.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_check_box_pressed() -> void:
	SavePoint.vsinc = !SavePoint.vsinc
	if SavePoint.vsinc:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_max_fps_editor_text_changed(new_text: String) -> void:
	Engine.max_fps = type_convert(new_text,TYPE_INT)


func _on_music_set_pressed() -> void:
	grf_set.hide()
	msc_set.show()


func _on_all_sound_value_changed(value: float) -> void:
	pass # Replace with function body.
