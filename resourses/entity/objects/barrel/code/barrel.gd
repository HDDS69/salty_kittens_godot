extends RigidBody2D


func death():
	$CollisionShape2D.set_deferred("disabled", true);
	self.gravity_scale = 0.0
	$Barrel.visible = false
	$AnimatedSprite2D.play("explosion")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func damage(dmg):
	if dmg >= 1:
		death()
