extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chace = false
var shoot_timer = false
var speed = 1000
var hit_ft = false
var Death = false
var helth = 3
var count = 1
var recharge = false
@onready var nav := $NavigationAgent2D
@export var bullet : PackedScene
@export var player : Node2D

func _physics_process(delta):
	print(chace)
	$ProgressBar.value = helth
	# Add the gravity.
	if hit_ft and player.hit :
		death()
		
	if count <= 0 :
		recharge = true
	elif count == 0 and recharge :
		$recharge.start()
		#$AnimatedSprite2D.self_modulate == "#ff0000"
	else:	
		if chace :
			var direction = to_local(player.global_position).normalized()
			position.y = player.position.y - 200
			velocity.x = speed * direction.x 
		if shoot_timer and chace:
			$Timer.start()
			shoot_timer = false

	move_and_slide()
	
	
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
	count -= 1
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Area2D/Marker2D.global_transform
	shoot_timer = true
#функция смерти
func death():
	helth -=1
	if helth <= 0 and Death == false:
		Death = true
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished #дождаться окончании анимации
		queue_free()


func _on_death_2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == 'hit' or area.name == 'hit2':
		hit_ft = true



func _on_timer_timeout():
	shoot()


func _on_way_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chace = true


func _on_way_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chace = false


func _on_shoot_body_entered(body: Node2D) -> void:
	if body.name == "player":
		shoot_timer = true


func _on_shoot_body_exited(body: Node2D) -> void:
	if body.name == "player":
		shoot_timer = false


func _on_recharge_timeout() -> void:
	count = 1
	recharge = false
	#$AnimatedSprite2D.self_modulate == "#ffffff"
