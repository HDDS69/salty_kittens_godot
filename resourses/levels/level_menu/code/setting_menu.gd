extends Node2D

@onready var grf_set = $setting/graphics_button/graphics
@onready var msc_set = $setting/music_set/music_list

@onready var all_sound_value = $setting/music_set/music_list/all_sound/music_value
@onready var music_value = $setting/music_set/music_list/music/music_value
@onready var noise_value = $setting/music_set/music_list/noise/music_value
@onready var sound_value = $setting/music_set/music_list/sound/music_value

@onready var max_fps = $setting/graphics_button/graphics/max_fps_label/max_fps_editor
@onready var vsinc_checkbox = $setting/graphics_button/graphics/v_sinc_label/CheckBox
@onready var fullscreen_checkbox = $setting/graphics_button/graphics/CheckBox2

@onready var al_s = $setting/music_set/music_list/all_sound
@onready var msc = $setting/music_set/music_list/music
@onready var nse = $setting/music_set/music_list/noise
@onready var snd = $setting/music_set/music_list/sound

func _ready() -> void:
	max_fps.text = ' ' + type_convert(Engine.max_fps,TYPE_STRING)
	vsinc_checkbox.button_pressed = SavePoint.vsinc
	fullscreen_checkbox.button_pressed = SavePoint.fullscreen
	
	all_sound_value.text = str(int((SavePoint.volume['Master'] + 80)/80 * 100))+"%"
	al_s.value = SavePoint.volume['Master']
	music_value.text = str(int((SavePoint.volume['music'] + 80)/80 * 100))+"%"
	msc.value = SavePoint.volume['music']
	noise_value.text = str(int((SavePoint.volume['noise'] + 80)/80 * 100))+"%"
	nse.value = SavePoint.volume['noise']
	sound_value.text = str(int((SavePoint.volume['sound'] + 80)/80 * 100))+"%"
	snd.value = SavePoint.volume['sound']

func _on_quit_setting_pressed() -> void:
	SavePoint.save_game()
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
	SavePoint.max_fps = Engine.max_fps


func _on_music_set_pressed() -> void:
	grf_set.hide()
	msc_set.show()


func _on_all_sound_value_changed(value: float) -> void:
	change_volume(all_sound_value,value,'Master')


func _on_music_value_changed(value: float) -> void:
	change_volume(music_value,value,'music')


func _on_noise_value_changed(value: float) -> void:
	change_volume(noise_value,value,'noise')


func _on_sound_value_changed(value: float) -> void:
	change_volume(sound_value,value,'sound')
