extends CharacterBody2D

var broke = false
var SPEED = 200.0
var JUMP_VELOCITY = -450.0
var spawn_pos = Vector2(0,0)
var health = 3
enum states {walk, attack, sleep,death}
var state: states = states.walk

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var granade : PackedScene
@onready var anim = $CollisionShape2D/AnimatedSprite2D
@onready var anim1 = $CollisionShape2D/effect
@onready var blaster_texture = $blaster
@onready var hit = $hit
@onready var sound_jump = $music/jump
@onready var sound_land = $music/land
@onready var Rtext = $CollisionShape2D/recharge
@onready var timer = $Timer
@onready var timer_i = $Timer_invulnerability
@onready var marker = $blaster/Marker2D

var salt = 0
var land = false
var invulnerability = false
var direction = 0.0
var blaster = false
var count = 3
var transition = false

func _process(delta: float) -> void:
	if velocity.y > 0:
		land = true
	
	if state == states.walk:
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
			if land and velocity.y == 0:
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
				
			if velocity.y > 0:
				anim.play("fall")
		if Input.is_action_just_pressed('dash'):
			velocity.x = direction * (SPEED * 150)
		if Input.is_action_just_pressed("ui_hit_player0"):
			if blaster and count > 0:
				blaster_texture.shoot()
			else:
				if is_on_floor():
					state = states.attack
					hit.monitoring = true
					anim.play("hit")
					await anim.animation_finished
					hit.monitoring = false
					state = states.walk
		
		if count == 0 :
			timer.start()
			count = -1000
			Rtext.text = "[wave = 30]перезарядка..."
		
		if direction == -1:
			anim.flip_h = true
			hit.position.x = -47
			
		elif direction == 1:
			anim.flip_h = false
			hit.position.x = 42
	
	elif state == states.sleep:
		velocity = Vector2(0,0)
		anim.play("sleep")
		await anim.animation_finished
	elif state == states.attack:
		velocity = Vector2(0,0)
	elif state == states.death:
		velocity = Vector2(0,0)
		anim.play("death")
	
	if not is_on_floor():
		velocity.y += gravity * delta

				
	move_and_slide()

func death():
	state = states.death
	await anim.animation_finished
	position = spawn_pos
	health = 3
	state = states.walk

func damage(dmg):
	if not invulnerability:
		health -= dmg
		timer_i.start()
		invulnerability = true
	if health <= 0:
		death()
		
func sleep(x, y):
	if state == states.walk:
		spawn_pos = Vector2(x, y)
		anim.flip_h = false
		invulnerability = true
		state = states.sleep
	else:
		state = states.walk
		invulnerability = false

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

func _on_hit_body_entered(body: Node2D) -> void:
	if body.name != 'TileMapLayer' and body.name != "salty platform":
		body.damage(1)
