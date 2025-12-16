extends Control
var setting = false
var fullscreen = false
var platform = OS.get_name()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	if platform == "Android":
		SavePoint.mobile_control = true
		SavePoint.fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$"../../mobile controller".visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and setting != true:
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible

func _on_resume_pressed() -> void:
	self.hide()
	get_tree().paused = false
	self.visible = false
	setting = false

#кнопка при которой происходит раскрытие на весь экран
func _on_full_screen_pressed() -> void:
	SavePoint.fullscreen = !SavePoint.fullscreen
	if SavePoint.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


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
		$"../../mobile controller".visible = true
	else :
		$"../../mobile controller".visible = false


func _on_quit_pressed() -> void:
	$"../..".broke = true
	get_tree().paused = false
	get_tree().change_scene_to_file("res://resourses/levels/level_menu/code/menu_new.tscn")


func _on_h_scroll_bar_value_changed(value: float) -> void:
	$"../setting/Panel/VBoxContainer/light/music_value".text  = str(int((value + 80)/80 * 100))+"%"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
