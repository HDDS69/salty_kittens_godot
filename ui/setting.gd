extends Control

@onready var controller =  $"../../players/player/mobile_controller"
@onready var setting =  $"."
var visible_controller = false
var fullscreen = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since theprevious frame.
func _process(delta):
	pass
	#if visible_controller == true:
	#	controller.show()
	#else:
	#	controller.hide()


func _on_controll_pressed():
	visible_controller != visible_controller

func _on_quit_setting_pressed():
	self.hide()


func _on_full_screen_pressed():
	fullscreen = !fullscreen
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
