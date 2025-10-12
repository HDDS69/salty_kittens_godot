extends RigidBody2D

enum states {idle,attack,wait,death}
var state: states = states.idle

func _process(delta: float) -> void:
	if state == states.idle:
		pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass # Replace with function body.
