extends Area2D
@export var stone : PackedScene
var he = true


@onready var ui = $ui
@onready var anim = $CollisionShape2D/AnimatedSprite2D

func damage(_dmg):
	var stone_1 = stone.instantiate()
	stone_1.directionFALL = 1
	add_child(stone_1)

func _on_body_entered(body):
	if body.name == "player":
		ui.show()

func _on_body_exited(body):
	if body.name == "player":
		ui.hide()
