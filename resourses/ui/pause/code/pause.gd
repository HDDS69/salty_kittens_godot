extends Control
var setting = false
var fullscreen = false
var platform = OS.get_name()
@onready var control = $"../../mobile controller"

@onready var all_sound_value = $"../setting/music_set/music_list/all_sound/music_value"
@onready var music_value = $"../setting/music_set/music_list/music/music_value"
@onready var noise_value = $"../setting/music_set/music_list/noise/music_value"
@onready var sounc_value = $"../setting/music_set/music_list/sound/music_value"

@onready var grf_set = $"../setting/graphics_button/graphics"
@onready var msc_set = $"../setting/music_set/music_list"

func change_volume(txt,value,buss):
	txt.text  = str(int((value + 80)/80 * 100))+"%"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(buss),value)

func _ready() -> void:
	self.visible = false
	if platform == "Android":
		SavePoint.mobile_control = true
		#SavePoint.fullscreen = true
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		control.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and setting != true:
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible

func _on_resume_pressed() -> void:
	self.hide()
	get_tree().paused = false
	self.visible = false
	setting = false


func _on_settings_pressed() -> void:
	$"../setting".visible = true
	$".".visible = false
	setting = true


func _on_quit_setting_pressed() -> void:
	$"../setting".visible = false
	$".".visible = true
	setting = false


func _on_controll_pressed() -> void:
	SavePoint.mobile_control = !SavePoint.mobile_control
	if SavePoint.mobile_control :
		control.visible = true
	else :
		control.visible = false


func _on_quit_pressed() -> void:
	$"../..".broke = true
	get_tree().paused = false
	get_tree().change_scene_to_file("res://resourses/levels/level_menu/code/menu_new.tscn")

func _on_check_box_pressed() -> void:
	SavePoint.vsinc = !SavePoint.vsinc
	if SavePoint.vsinc:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_ful_screen_pressed() -> void:
	SavePoint.fullscreen = !SavePoint.fullscreen
	if SavePoint.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_max_fps_editor_text_changed(new_text: String) -> void:
	Engine.max_fps = type_convert(new_text,TYPE_INT)


func _on_music_value_changed(value: float) -> void:
	change_volume(music_value,value,'music')


func _on_noise_value_changed(value: float) -> void:
	change_volume(noise_value,value,'noise')


func _on_sound_value_changed(value: float) -> void:
	change_volume(sounc_value,value,'sound')


func _on_all_sound_value_changed(value: float) -> void:
	change_volume(all_sound_value,value,'master')


func _on_music_set_pressed() -> void:
	grf_set.hide()
	msc_set.show()
	


func _on_graphics_button_pressed() -> void:
	grf_set.show()
	msc_set.hide()
