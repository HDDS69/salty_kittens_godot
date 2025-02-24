extends Area2D
var entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true and $"../player".actiom == true:
		$"../player".health = 3
		$"../player".sleep(self.position.x -10,self.position.y-30)
		self.hide()
		
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		$ui.show()
		


func _on_body_exited(body):
	if body.name == "player":
		entered = false
		self.show()
		$ui.hide()
