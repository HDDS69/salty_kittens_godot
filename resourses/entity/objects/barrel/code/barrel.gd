extends CharacterBody2D


# Called when the node enters the scene tree for the first time.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player' :
		death()

func death():
	$CollisionShape2D.set_deferred("disabled", true);
	$Barrel.visible = false
	$AnimatedSprite2D.play("explosion")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func damage(dmg):
	if dmg >= 1:
		death()
