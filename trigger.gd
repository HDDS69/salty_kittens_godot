extends Area2D
var entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true and $"../player".actiom == true:
		$Label.visible = !$Label.visible
		
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		$"Untitled06-12-202411-00-24".show()
		


func _on_body_exited(body):
	if body.name == "player":
		entered = false
		$"Untitled06-12-202411-00-24".hide()
