extends RigidBody2D
@export var stone : PackedScene

#@onready var player = $"../player"
@onready var ui = $ui
@onready var anim = $CollisionShape2D/AnimatedSprite2D

func damage(_dmg):
	apply_impulse(Vector2(900,-600))
	#var stone_1 = stone.instantiate()
	#stone_1.directionFALL = -1
	#add_child(stone_1)
	
func _on_body_entered(body):
	if body.name == "player":
		ui.show()

func _on_body_exited(body):
	if body.name == "player":
		ui.hide()
