extends Node2D
@onready var setting = $setting2
var fly = false
var entered_play
var entered_setting
var entered_quite
#@onready var node = get_node("res://manager.gd")
#@onready var controller = node.visible_controller
func _process(delta):
	#if fly == true:
	#	$player.velocity.y = 2
	#if $player.actiom == true and entered_play == true:
	#	_on_play_pressed()
	#if $player.actiom == true and entered_setting == true:
	#	_on_setting_pressed()
	#if $player.actiom == true and entered_quite == true:
	#	_on_play_2_pressed()
	pass
func _on_play_2_pressed():
	get_tree().quit()
	$click.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("level.tscn")
	$click.play()

func _on_setting_pressed():
	setting.show()
	$click.play()

func _on_quit_setting_pressed():
	setting.hide()
	$click.play()

func _on_controll_pressed():
	$click.play()
#	controller = !controller


func _on_area_2d_body_entered(body):
	$fly.play()
	body.velocity.y -= 600
	entered_play = true
func _on_area_2d_2_body_entered(body):
	fly = true
	entered_setting = true


func _on_area_2d_2_body_exited(body):
	fly = false
	entered_setting = false


func _on_area_2d_body_exited(body):
	entered_play = false

func _on_area_2d_3_body_entered(body):
	entered_quite = true
	$fly.play()
	body.velocity.y -= 600

func _on_area_2d_3_body_exited(body):
	entered_quite = false
