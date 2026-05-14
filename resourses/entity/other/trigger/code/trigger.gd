extends Area2D
var entered = false
@onready var sprite = $Untitled04152026105058
@export var scene : String
@export var v2: Vector2
		
func _input(event: InputEvent) -> void:
	if entered and event.is_action_pressed("ui_action_button"):
		SavePoint.v2 = v2
		get_tree().change_scene_to_file(scene)
		
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		sprite.show()
		
func _on_body_exited(body):
	if body.name == "player":
		entered = false
		sprite.hide()
