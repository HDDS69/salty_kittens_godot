extends RigidBody2D

enum states {idle,attack,wait,death}
var state: states = states.idle

func _process(delta: float) -> void:
	if state == states.idle:
		pass
	elif  state == states.attack:
		pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if state != states.wait:
			state = states.wait
			print(1)
			$Timer.start(5)
			


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player" and state == states.wait:
		state = states.idle
	


func _on_timer_timeout() -> void:
	state = states.attack
	print(2)


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if state == states.attack:
		print(12)


func _on_body_entered(body: Node) -> void:
	if state == states.attack:
		print(12)
