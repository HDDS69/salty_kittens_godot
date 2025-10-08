extends RigidBody2D

var costil = false

#функция смерти
func death():
	$radius.monitoring = true
	$Boom.visible = false
	self.freeze = true
	$sound.play()
	$AnimatedSprite2D.play("default")
	await $AnimatedSprite2D.animation_finished
	queue_free()

#по окончанию таймера вызывается функция смерти
func _on_timer_timeout():
	death()

# проверяем тела которые находятся в радиусе взрыва и "убиваем" если есть в радиусе
func _on_radius_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != "salty platform":
		body.death()

#при соприкосновении к любому телу начинается 1секундный таймер
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if costil == false :
		costil = true
		$Timer.start()
