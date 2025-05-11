extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chace = false
var shoot_timer = false
var speed = 550
var hit_ft = false
var Death = false
var helth = 3
var count = 3
var recharge = false
var stupidvar = true

@export var bullet : PackedScene
@export var player : Node2D
@onready var anim = $AnimatedSprite2D
@onready var HP_bar = $ProgressBar
@onready var recharge_timer = $recharge
@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D/AudioStreamPlayer2D
@onready var marker = $Area2D/Marker2D
func _physics_process(delta):
	HP_bar.value = helth
	
	if hit_ft and player.hit :
		death()
	
	if count <= 0 and stupidvar :
		recharge = true
		stupidvar = false
		
	if count <= 0 and recharge:
		recharge = false
		anim.self_modulate = "#ff0000"
		recharge_timer.start()
		
	if chace and stupidvar:
			var direction = to_local(player.global_position).normalized()
			position.y = player.position.y - 200
			velocity.x = speed * direction.x
			if velocity.x < 0:
				anim.rotation = -0.1
			elif velocity.x > 0:
				anim.rotation = 0.1
			else :
				anim.rotation = 0
			move_and_slide()
	if shoot_timer and chace:
			timer.start()
			shoot_timer = false
	
	
func _on_death_body_entered(body):
	if body.name == "player":
		pass

func _on_death_2_body_entered(body):
	if body.name == "player":
		if body.invulnerability == false:
			body.invulnerability = true
			body.invulnerability_start = true
			body.health -= 1
			
func shoot():
	if count > 0 and chace :
		sound.play()
		count -= 1
		var b = bullet.instantiate()
		get_tree().root.add_child(b)
		b.transform = marker.global_transform
		shoot_timer = true
#функция смерти
func death():
	helth -=1
	if helth <= 0 and Death == false:
		Death = true
		anim.play("death")
		await anim.animation_finished #дождаться окончании анимации
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
	count = 4
	anim.self_modulate = "#ffffff"
	stupidvar = true
