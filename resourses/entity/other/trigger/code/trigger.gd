extends Area2D
var entered = false
@onready var label = $Label
@onready var sprite = $"Untitled06-12-202411-00-24"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("ui_action_button"):
			get_tree().change_scene_to_file("res://resourses/levels/level_2/code/level2.tscn")
		
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		sprite.show()
		
func _on_body_exited(body):
	if body.name == "player":
		entered = false
		sprite.hide()
