extends Node2D
@onready var setting = $setting
var yes = true
var add = 0
func _on_play_2_pressed():
	get_tree().quit()

func _on_play_pressed():
	$sound/click.play()
	get_tree().change_scene_to_file("level.tscn")

func _on_setting_pressed():
	setting.show()
	$sound/click.play()

func _on_quit_setting_pressed():
	setting.hide()
	$sound/click.play()

func _on_autors_pressed() -> void:
	$sound/click.play()
	get_tree().change_scene_to_file("res://autors_level/autors_level.tscn")
func spawn():
	var dup = $player.duplicate()
	dup.position = $player.position + Vector2(50, 0)
	self.get_parent().add_child(dup)
