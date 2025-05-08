extends CharacterBody2D


# Called when the node enters the scene tree for the first time.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player' :
		death()

func death():
	$CollisionShape2D.set_deferred("disabled", true);
	$Borel3.visible = false
	$AnimatedSprite2D.play("boom")
	await $AnimatedSprite2D.animation_finished
	queue_free()
