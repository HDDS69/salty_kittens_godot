extends RigidBody2D
@export var stone : PackedScene

#@onready var player = $"../player"
@onready var ui = $ui
@onready var anim = $AnimatedSprite2D
var x = 0
var duck = false
#func _process(_delta: float) -> void:
	##print(linear_velocity)

func damage(_dmg):
	x = randfn(-500,500)
	apply_impulse(Vector2(x,-600))
	duck = true
	#var stone_1 = stone.instantiate()
	#stone_1.directionFALL = -1d
	#add_child(stone_1)
	
#func _on_body_entered(body):
	#if body.name == "player":
		#ui.show()
#
#func _on_body_exited(body):
	#if body.name == "player":d
		#ui.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if duck and body.name != 'TileMapLayer' and self != body:
		body.damage(100)
		anim.play('death')
		await anim.animation_finished
		queue_free()
		
