extends Node2D
@onready var setting = $setting
var yes = true
var add = 0
var platform = OS.get_name()

func _ready() -> void:
	if platform == "Android":
		SavePoint.fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_play_pressed():
	$sound/click.play()
	get_tree().change_scene_to_file("level.tscn")

func _on_autors_pressed() -> void:
	$sound/click.play()
	get_tree().change_scene_to_file("res://autors_level/autors_level.tscn")
	
func spawn():
	var dup = $player.duplicate()
	dup.position = $player.position + Vector2(50, 0)
	self.get_parent().add_child(dup)


func _on_setting_button_pressed() -> void:
	setting.show()
	$sound/click.play()


func _on_quite_pressed() -> void:
	get_tree().quit()
