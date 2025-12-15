extends Area2D
@export var dialog_key = ''
var area_active = false

func _input(event: InputEvent) -> void:
	if area_active and event.is_action_pressed("ui_action_button"):
		Signalbus.emit_signal('display_dialog',dialog_key)
		


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		area_active = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		area_active = false
