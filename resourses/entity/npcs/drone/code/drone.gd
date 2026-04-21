extends RigidBody2D

@export var bullet : PackedScene
@export var salt : PackedScene
@export var hp : int
var hp_max 
@onready var anim = $AnimatedSprite2D
@onready var timer_shot =  $"time to shot"
@onready var timer_recharge = $recharge
@onready var hp_bar = $ProgressBar
@onready var muzzle = $muzzle
@onready var muzzle_marker = $muzzle/Marker2D
@onready var area = $Area2D2
@onready var sound_shoot = $AudioStreamPlayer2D/AudioStreamPlayer2D
@onready var light1 = $PointLight2D7
@onready var light2 = $PointLight2D8

enum states {idle,attack,death,recharge,stun}
var state: states = states.idle
var count = 3
var x = 1
var y = 1
var z = 50
var player
var count_d = true

func _ready() -> void:
	hp_max = hp
	hp_bar.max_value = hp
	hp_bar.value = hp

func _physics_process(_delta: float) -> void:
	area.global_rotation = 0
	match state:
		states.idle:
				linear_velocity.x = 90 * x
				linear_velocity.y = 15 * y
		
				if linear_velocity.x > 0:
					anim.rotation = 0.1
				elif linear_velocity.x < 0:
					anim.rotation = -0.1
				else:
					anim.rotation = 0
		states.death:
			death()
		states.stun:
			linear_velocity = Vector2(0,0)
			anim.self_modulate = "0000ff"
			light1.color = "0000ff"
			light2.color = "0000ff"
		states.attack:
			var pos = player.position
			var direction =  to_local(player.global_position+Vector2(0,-35)).normalized()
			linear_velocity.x = 90 * direction.x 
			linear_velocity.y = 90 * direction.y
			muzzle.look_at(pos)
			if count == 0:
				state = states.recharge
			if timer_shot.is_stopped():
				timer_shot.start()
		states.recharge:
			linear_velocity = Vector2(0,0)
			anim.self_modulate = "#ff0000"
			light1.color = "#ff0000"
			light2.color = "#ff0000"
			if timer_recharge.is_stopped():
				timer_recharge.start()
		
func death():
	gravity_scale = 1.0
	inertia = 1.0
	spawn()
	anim.play("death")
	await anim.animation_finished
	queue_free()

func spawn():
	if count_d:
		var s = salt.instantiate()
		get_tree().root.add_child(s)
		s.transform = muzzle_marker.global_transform
		count_d = false
		
func damage(dmg):
	if randi_range(1,5) == 1:
		anim.play("invulnerability")
		await anim.animation_finished
		anim.play("default")
	else:
		hp -= dmg
	hp_bar.value = hp
	if hp == hp_max - 1:
		anim.play('damage')
	if hp <= hp_max /2:
		$GPUParticles2D.emitting = true
	if hp <= 0:
		state = states.death

func attack():
		count -=1
		sound_shoot.play()
		var b = bullet.instantiate()
		get_tree().root.add_child(b)
		b.transform = muzzle_marker.global_transform

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body
		state = states.attack
		
func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "player":
		state = states.idle
		player = null
		timer_shot.stop() 

func _on_timer_timeout() -> void:
	anim.self_modulate = "#ffffff"
	light1.color = "00a6a6"
	light2.color = "00a6a6"
	count = 3
	if state == states.recharge:
		state = states.attack
		
func _on_time_to_shot_timeout() -> void:
	attack()
	
func _on_timer_fly_timeout() -> void:
	x = -x

func _on_timer_y_timeout() -> void:
	y = -y

func _on_timer_z_timeout() -> void:
	z = -z

func stun():
	state = states.stun
	gravity_scale = 1.0
	inertia = 1.0
	$"../Timer_stun".start()
	

func _on_timer_stun_timeout() -> void:
	state = states.idle
	gravity_scale = 0.0
	inertia = 0.0
	anim.self_modulate = "#ffffff"
	light1.color = "00a6a6"
	light2.color = "00a6a6"
