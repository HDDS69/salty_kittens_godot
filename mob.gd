extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chace = false
var speed = 100
var hit_ft = false
var Death = false
@export var bullet : PackedScene
func _physics_process(delta):
	# Add the gravity.
	var player = $"../../player"
	if hit_ft and player.hit :
		death()
	#if not is_on_floor():
	#	velocity.y += gravity * delta
	var direction = (player.position - self.position).normalized()
	if chace == true:
		$Timer.start()
		velocity.x = direction.x * speed
	if chace == true:
		$Timer.start()
		velocity.y = direction.y * speed
	else:
		velocity.x = 0
	$Area2D.look_at(player.position)
	move_and_slide()

func _on_detector_body_entered(body):
	if body.name == "player":
		chace = true
		


func _on_detector_body_exited(body):
	if body.name == "player":
		chace = false


func _on_death_body_entered(body):
	if body.name == "player":
		pass

func _on_death_2_body_entered(body):
	if body.name == "player":
		if body.invulnerability == false:
			body.invulnerability = true
			body.invulnerability_start = true
			body.health -= 1
			#death()

func shoot():
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Area2D/Marker2D.global_transform
#функция смерти
func death():
	#await anim.Animation.finished дождаться окончании анимации
	queue_free()


func _on_death_2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == 'hit' or area.name == 'hit2':
		hit_ft = true



func _on_timer_timeout():
	shoot()
