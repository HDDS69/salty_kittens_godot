extends Control
var setting = false
var fullscreen = false
var platform = OS.get_name()
@onready var control = $"../../mobile controller"
@onready var vsinc = $"../setting/graphics/graphics_button/v_sinc_label/CheckBox"
@onready var max_fps_editor = $"../setting/graphics/graphics_button/max_fps_label/max_fps_editor"
# Called when the node enters the scene tree for the first time.
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


func _on_h_scroll_bar_value_changed(value: float) -> void:
	$"../setting/music/HScrollBar/music_value".text  = str(int((value + 80)/80 * 100))+"%"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)


func _on_check_box_pressed() -> void:
	if vsinc.button_pressed == true:
		DisplayServer.window_set_vsync_mode(1)
	else:
		DisplayServer.window_set_vsync_mode(0)


func _on_ful_screen_pressed() -> void:
	SavePoint.fullscreen = !SavePoint.fullscreen
	if SavePoint.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_max_fps_editor_text_changed(new_text: String) -> void:
	Engine.max_fps = type_convert(max_fps_editor.text,TYPE_INT)
