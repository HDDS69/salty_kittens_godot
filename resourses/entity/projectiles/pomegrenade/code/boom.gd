extends RigidBody2D

var costil = false

# функция смерти
func death():
	$radius.monitoring = true
	$Boom.visible = false
	self.freeze = true
	$sound.play()
	$AnimatedSprite2D.play("default")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func damage(_dmg):
	death()
# по окончанию таймера вызывается функция смерти
func _on_timer_timeout():
	death()

# проверяем тела которые находятся в радиусе взрыва и "убиваем" если есть в радиусе
func _on_radius_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != "salty platform" and body.name != "player":
		body.damage(1)

# при соприкосновении к любому телу начинается 1секундный таймер
func _on_body_shape_entered(_body_rid: RID, _body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if costil == false :
		costil = true
		$Timer.start()
