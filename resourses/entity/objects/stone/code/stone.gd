extends RigidBody2D

@onready var ui = $ui
@onready var anim = $AnimatedSprite2D
@onready var kil_zone = $Area2D
var x = 0

func damage(_dmg):
	x = randfn(-500,500)
	apply_impulse(Vector2(x,-600))
	kil_zone.monitoring = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != 'TileMapLayer' and self != body and body.name != 'player':
		body.damage(100)
		anim.play('death')
		await anim.animation_finished
		queue_free()
	kil_zone.set_deferred('monitoring',false)


func _on_ent_body_exited(body: Node2D) -> void:
	if body.name == "player":
		ui.hide()


func _on_ent_body_entered(body: Node2D) -> void:
	if body.name == "player":
		ui.show()
