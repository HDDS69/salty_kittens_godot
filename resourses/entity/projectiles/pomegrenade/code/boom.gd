extends RigidBody2D

var count = 0
var costil = false
const SPEED = 9
const JUMP_VELOCITY = -400.0
var pos
var pos_to


func _physics_process(delta):
	## Add the gravity.
	if pos_to :
		self.position = pos
	if count <= 300 :
		self.position += SPEED * transform.x
	else :
		self.velocity.x = 0


func death():
	pos_to = true
	pos = self.position
	$radius.monitoring = true
	$Boom.visible = false
	$AnimatedSprite2D.play("default")
	$sound.play()
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_timer_timeout():
	death()


func _on_radius_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != "salty platform":
		body.death()
	


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	count += 1
	if costil == false :
		costil = true
		$Timer.start()
