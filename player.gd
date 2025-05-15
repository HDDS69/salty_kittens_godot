extends CharacterBody2D
var broke = false
var SPEED = 200.0
var JUMP_VELOCITY = -450.0
var x_cord = 1
var y_cord = 400
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var granade : PackedScene
var health = 3
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
var alive = true
var death1 = false
var land = false
var invulnerability = false
var invulnerability_start = false
var hit = false
var one
var two
var salty_platform = false
var direction = 0.0
var actiom = false
var sleep_anim = false
var blaster = false
var recharge = true
var count = 3
var transition = false
func _process(delta: float) -> void:
	invulnerability_timer_start()
	if velocity.y > 0:
		land = true
	death()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_focus_next") and salty_platform == false:
		salty_platform = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if alive == true:
		if sleep_anim :
			velocity.y += 10
			one = self.position.x
			two = self.position.y
			anim.flip_h = false
			anim.play("sleep")
			await anim.animation_finished
			self.position.x = one
			self.position.y = two
		else:
			if Input.is_action_just_pressed("1"):
				blaster_texture.visible = false
				blaster = false
			if Input.is_action_just_pressed("2"):
				blaster = true
				blaster_texture.visible = true
			if Input.is_action_just_pressed("ui_hit_player0") or hit:
				if blaster and count > 0:
					blaster_texture.shoot()
				else:
					if is_on_floor():  # Проверяем, находится ли игрок на земле
						hit = true
						one = self.position.x
						two = self.position.y
						anim.play("hit")
						await anim.animation_finished 
						hit = false
						self.position.x = one
						self.position.y = two
					else:
						hit = false 
			# Handle jump.
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				anim.play("jump")
				sound_jump.play()
			if count == 0:
				timer.start()
				count = -1000
				Rtext.text = "[wave = 30]перезарядка..."
			if Input.is_action_just_pressed("boom"):
				boom()
			direction = Input.get_axis("ui_left_player", "ui_right_player")
			if direction:
				transition = true
				velocity.x = direction * SPEED
				if velocity.y  == 0 :
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
				elif velocity.y  == 0 :
					if transition :
						anim.play("transition")
						await anim.animation_finished
						transition = false
					anim.play("hidel")
			if direction == -1:
				anim.flip_h = true
				hit1.set_deferred("monitorable", false)
				hit2.set_deferred("monitorable", true)
			elif direction == 1:
				anim.flip_h = false
				hit1.set_deferred("monitorable", true)
				hit2.set_deferred("monitorable", false)
			if velocity.y > 0:
				anim.play("fall")
			move_and_slide()
func death():
	if health == 0 :
		alive = false
		anim.play("death")
		await anim.animation_finished
		death1 = true   
		alive = true
		death1 = false
		health = 3
		position.y = y_cord
		position.x = x_cord  
		
func attack():
	if Input.is_action_just_pressed("ui_hit_player0") or hit:
				if blaster and count >0:
					blaster_texture.shoot()
				else:
					hit = true
					one = self.position.x
					two = self.position.y
					anim.play("hit")

func invulnerability_timer_start():
	if invulnerability_start == true:
		invulnerability_start = false
		timer_i.start()
		
func sleep(x,y):
	sleep_anim = !sleep_anim
	x_cord = x
	y_cord = y

func _on_timer_invulnerability_timeout():
	invulnerability = false
	
func boom():
	var g = granade.instantiate()
	get_tree().root.add_child(g)
	g.transform = marker.global_transform



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
