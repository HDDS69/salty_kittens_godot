extends CharacterBody2D

var broke = false
var SPEED = 200.0
var JUMP_VELOCITY = -450.0
var spawn_pos = Vector2(0,0)
var health = 3000
enum states {walk, attack, sleep}
var state: states = states.walk  # Исправлено: было states.idle, но у вас нет idle в enum

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var granade : PackedScene
@onready var anim = $CollisionShape2D/AnimatedSprite2D
@onready var anim1 = $CollisionShape2D/effect
@onready var blaster_texture = $blaster
@onready var hit1 = $hit
@onready var hit2 = $hit2
@onready var sound_jump = $music/jump
@onready var sound_land = $music/land
@onready var Rtext = $CollisionShape2D/recharge
@onready var timer = $Timer
@onready var timer_i = $Timer_invulnerability
@onready var marker = $blaster/Marker2D

var salt = 0
var land = false
var invulnerability = false
var invulnerability_start = false
var direction = 0.0
var blaster = false
var count = 3
var transition = false

func _process(delta: float) -> void:
	if velocity.y > 0:
		land = true
	
	if state == states.walk:  # Исправлено: было = вместо ==
		if Input.is_action_just_pressed("boom"):
			boom()
		
		if Input.is_action_just_pressed("2"):
			blaster = !blaster
			blaster_texture.visible = blaster
			
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			anim.play("jump")
			sound_jump.play()
			velocity.y = JUMP_VELOCITY
		
		direction = Input.get_axis("ui_left_player", "ui_right_player")
		if direction:
			transition = true
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("run")
				land = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if land == true and velocity.y == 0:
				anim1.play("land")
				anim.play("land")
				sound_land.play()
				await anim.animation_finished
				land = false
			elif velocity.y == 0:
				if transition and anim.visible == false:
					anim.play("transition")
					await anim.animation_finished
					transition = false
				anim.play("hidel")
		
		if Input.is_action_just_pressed("ui_hit_player0"):
			if blaster and count > 0:
				blaster_texture.shoot()
			else:
				if is_on_floor():
					state = states.attack
					anim.play("hit")
					await anim.animation_finished 
					state = states.walk
		
		if count == 0:
			timer.start()
			count = -1000
			Rtext.text = "[wave = 30]перезарядка..."
		
		if direction == -1:
			anim.flip_h = true
			hit1.set_deferred("monitorable", false)
			hit2.set_deferred("monitorable", true)
		elif direction == 1:
			anim.flip_h = false
			hit1.set_deferred("monitorable", true)
			hit2.set_deferred("monitorable", false)
	
	elif state == states.sleep:
		anim.play("sleep")
		await anim.animation_finished
	elif state == states.attack:
		velocity = Vector2(0,0)
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			anim.play("fall")
				
	move_and_slide()

func death():
	anim.play("death")
	await anim.animation_finished
	health = 3
	position = spawn_pos

func damage(dmg):
	health -= dmg
	if health == 0:
		death()

func invulnerability_timer_start():
	if invulnerability_start == true:
		invulnerability_start = false
		timer_i.start()
		
func sleep(x, y):
	spawn_pos = Vector2(x, y)
	anim.flip_h = false
	state = states.sleep


	
	


func _on_timer_invulnerability_timeout():
	invulnerability = false
	
func boom():
	var g = granade.instantiate()
	get_tree().root.add_child(g)
	g.transform = marker.global_transform
	g.apply_impulse(marker.global_transform.x.normalized() * 600)

func _on_timer_timeout():
	count = 3
	Rtext.text = ""
	
func _on_light_pressed() -> void:
	SavePoint.light = !SavePoint.light

func animTV() -> void:
	SPEED = 100
	JUMP_VELOCITY = -250.0
	anim.visible = false
	anim = $CollisionShape2D/TV
	anim.visible = true
