extends Node2D
@onready var setting = $setting
var yes = true
var add = 0
var platform = OS.get_name()
@onready var player = $player
@onready var click_sound = $sound/click


func _ready() -> void:
	if platform == "Android":
		SavePoint.fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DiscordRPC.app_id = 1423378584986456245 # Application ID
		#DiscordRPC.details = "релиза не будет"
		DiscordRPC.state = "в меню"
		#DiscordRPC.large_image = "background" # Image key from "Art Assets"
		DiscordRPC.large_image_text = "котята лого"
		#DiscordRPC.small_image = "drone" # Image key from "Art Assets"
		#DiscordRPC.small_image_text = "ломаю железяки"
		DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	#	 DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"
		DiscordRPC.refresh() # Always refresh after changing the values!

func _on_play_pressed():
	#click_sound.play()
	get_tree().change_scene_to_file("res://resourses/levels/level_1/code/level.tscn")

	
func spawn():
	var dup = player.duplicate()
	dup.position = player.position + Vector2(50, 0)
	self.get_parent().add_child(dup)


func _on_settings_button_pressed() -> void:
	setting.show()
	click_sound.play()

func _on_authors_pressed() -> void:
	click_sound.play()
	get_tree().change_scene_to_file("res://resourses/levels/level_autors/autors_level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_test_pressed() -> void:
	get_tree().change_scene_to_file("res://resourses/levels/test/code/test.tscn")
