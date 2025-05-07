extends CharacterBody2D

const SPEED = 4500.0
const JUMP_VELOCITY = -400.0
var clone = false

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


func _on_timer_timeout() -> void:
	$CollisionShape2D/AnimatedSprite2D.play("hit")

func death():
	queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$Icon.visible = !$Icon.visible
			$CollisionShape2D/AnimatedSprite2D/Angry.visible = false
			$Heart.visible = false
			if clone == false :
				if $"..".yes :
					$"..".add += 1
					$"../bg/count_clicker".text = str($"..".add)
				else :
					$"../bg/count_clicker".text = "сломанная фигня"
				if $"..".add == 666 :
					$"..".yes = false
					for i in range(50):
						var dup = self.duplicate()
						dup.clone = true
						dup.position = self.position + Vector2(50, 0)
						$"..".get_parent().add_child(dup)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			$Icon.visible = false
			$CollisionShape2D/AnimatedSprite2D/Angry.visible = false
			$Heart.visible = !$Heart.visible
		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			$Icon.visible = false
			$CollisionShape2D/AnimatedSprite2D/Angry.visible = !$CollisionShape2D/AnimatedSprite2D/Angry.visible 
			$Heart.visible = false
