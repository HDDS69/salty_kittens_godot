extends Area2D
var entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		if Input.is_action_just_pressed("ui_action_button"):
			$Label.visible = !$Label.visible
		
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		$"Untitled06-12-202411-00-24".show()
		
func _on_body_exited(body):
	if body.name == "player":
		entered = false
		$"Untitled06-12-202411-00-24".hide()
