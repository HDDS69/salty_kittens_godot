extends RigidBody2D
@export var node : Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if 'velocity' in body:
		self.apply_force(body.velocity*5)

func damage(dmg):
	apply_force(Vector2(0,dmg)*10000)
