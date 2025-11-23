extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

var direction = 0
var JUMP_VELOCITY = -150
func _process(delta: float) -> void:
	direction = Input.get_axis("ui_left_player", "ui_right_player")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
