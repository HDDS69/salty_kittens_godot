extends RigidBody2D

var costil = false

func death():
	$radius.monitoring = true
	$Boom.visible = false
	self.freeze = true
	$sound.play()
	$AnimatedSprite2D.play("default")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func _on_timer_timeout():
	death()

func _on_radius_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != "salty platform":
		body.death()
	
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if costil == false :
		costil = true
		$Timer.start()
