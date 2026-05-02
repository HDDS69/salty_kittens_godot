extends Area2D
var entered = false
# Called when the node enters the scene tree for the first time.
var player
@onready var ui = $ui
		
func _input(event: InputEvent) -> void:
	if entered and event.is_action_pressed("ui_action_button"):
		player.health = 3
		player.sleep(self.position.x,self.position.y)
		self.hide()
		
func _on_body_entered(body):
	if body.name == "player":
		player = body
		entered = true
		ui.show()

func _on_body_exited(body):
	if body.name == "player":
		player = ''
		entered = false
		self.show()
		ui.hide()
