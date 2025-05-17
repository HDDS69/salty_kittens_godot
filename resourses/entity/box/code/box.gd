extends Area2D
var entered = false
# Called when the node enters the scene tree for the first time.
@onready var player = $"../player"
@onready var ui = $ui
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("ui_action_button"):
			player.health = 3
			player.sleep(self.position.x -10,self.position.y-30)
			self.hide()
		
func _on_body_entered(body):
	if body.name == "player":
		entered = true
		ui.show()
		


func _on_body_exited(body):
	if body.name == "player":
		entered = false
		self.show()
		ui.hide()
