extends RigidBody2D

@export var bullet : PackedScene
@onready var anim = $AnimatedSprite2D
@onready var timer_shot =  $"time to shot"
@onready var timer_recharge = $recharge
@onready var hp_bar = $ProgressBar
@onready var muzzle = $muzzle
@onready var muzzle_marker = $muzzle/Marker2D
@onready var area = $Area2D2
@onready var sound_shoot = $AudioStreamPlayer2D/AudioStreamPlayer2D
enum states {idle,attack,death,recharge}
var state: states = states.idle
var hp = 3
var count = 3
var x = 1
var y = 1
var z = 50
var player

func _ready() -> void:
	hp_bar.value = hp

func _process(_delta: float) -> void:
	area.global_rotation = 0
	if state == states.idle:
		linear_velocity.x = 150 * x
		linear_velocity.y = 15 * y
		
		if linear_velocity.x > 0:
			anim.rotation = 0.1
		elif linear_velocity.x < 0:
			anim.rotation = -0.1
		else:
			anim.rotation = 0

	elif state == states.death:
		death()
		
	elif state == states.attack:
		var pos = player.position 
		var direction =  to_local(player.global_position+Vector2(0,-230)).normalized()
		linear_velocity.x = 150 * direction.x 
		linear_velocity.y = 150 * direction.y
		muzzle.look_at(pos)
		if count == 0:
			state = states.recharge
		if timer_shot.is_stopped():
			timer_shot.start()
	elif state == states.recharge:
		linear_velocity = Vector2(0,0)
		anim.self_modulate = "#ff0000"
		if timer_recharge.is_stopped():
			timer_recharge.start()
		

func death():
	gravity_scale = 1.0
	inertia = 1.0
	anim.play("death")
	await anim.animation_finished
	queue_free()

func damage(dmg):
	hp -= dmg
	hp_bar.value = hp
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
