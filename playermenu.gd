extends CharacterBody2D


const SPEED = 4500.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if randf() <0.01 :
		velocity.y += JUMP_VELOCITY 
		$CollisionShape2D/AnimatedSprite2D.play("jump")
	if randf() <0.01 :
		velocity.x = SPEED * delta * randf_range(-1,1)
		$CollisionShape2D/AnimatedSprite2D.play("run")
	if velocity.x < 0 :
				$CollisionShape2D/AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
				$CollisionShape2D/AnimatedSprite2D.flip_h = false
	move_and_slide()