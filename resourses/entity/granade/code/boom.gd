extends CharacterBody2D

var count = 0
var costil = false
const SPEED = 9
const JUMP_VELOCITY = -400.0
var pos
var pos_to

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	$Node2D.rotate(0.1)
	if pos_to :
		position = pos
	if count <= 3 :
		position += SPEED * transform.x
	else :
		velocity.x = 0
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func _on_area_2d_body_entered(body):
	count += 1
	if costil == false :
		costil = true
		$Timer.start()

func death():
	pos_to = true
	pos = self.position
	$radius.monitoring = true
	$Node2D/Boom.visible = false
	$AnimatedSprite2D.play("default")
	$sound.play()
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_timer_timeout():
	death()


func _on_radius_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != "salty platform":
		body.death()
	
