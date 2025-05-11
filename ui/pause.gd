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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if setting:
		pass
	else :
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().paused = !get_tree().paused
			self.visible = !self.visible
	#if visible_controller == true:
	#	$"../../mobile controller".show()
	#else:
	#	$"../../mobile controller".hide()

func _on_resume_pressed() -> void:
	self.hide
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
	get_tree().change_scene_to_file("res://menu.tscn")
