extends RigidBody2D
@export var node : Node
@onready var pin = $PinJoint2D
var hp = 3

func _ready() -> void:
	pin.node_a = node.get_path()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if 'velocity' in body:
		self.apply_force(body.velocity*5)

func damage(dmg):
	hp -=1
	if hp <= 0:
		queue_free()
	apply_force(Vector2(0,dmg)*10000)
