extends Area2D

@export var dialog_key = ''
var area_active = false
@onready var anim = $AnimatedSprite2D
@onready var ui = $ui
var dialog_img = preload("res://resourses/entity/npcs/TV/texture/TV.png")
var player : Object

func _ready() -> void:
	Signalbus.connect('dialog_finish',Callable(self,'on_dialog_finished'))
	
func _input(event: InputEvent) -> void:
	if area_active and event.is_action_pressed("ui_action_button"):
		Signalbus.emit_signal('display_dialog',dialog_key)

func on_dialog_finished(current_dialog_key):
	if current_dialog_key == dialog_key:
		player.animTV()
		anim.play("puf")
		await anim.animation_finished
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		player = body
		area_active = true
		ui.show()

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		area_active = false
		ui.hide()
