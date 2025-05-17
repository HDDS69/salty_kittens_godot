extends CharacterBody2D

const SPEED = 4500.0
const JUMP_VELOCITY = -400.0
var clone = false
@onready var anim = $CollisionShape2D/AnimatedSprite2D
@onready var angry = $CollisionShape2D/AnimatedSprite2D/Angry
@onready var heart = $Heart
@onready var icon = $Icon
@onready var menu = $".."
@onready var count = $"../bg/count_clicker"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if randf() <0.01 :
		velocity.y += JUMP_VELOCITY 
		anim.play("jump")
	if randf() <0.01 :
		velocity.x = SPEED * delta * randf_range(-1,1)
		anim.play("run")
	if velocity.x < 0 :
				anim.flip_h = true
	elif velocity.x > 0:
				anim.flip_h = false
	move_and_slide()


func _on_timer_timeout() -> void:
	anim.play("hit")

func death():
	queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			icon.visible = !icon.visible
			angry.visible = false
			heart.visible = false
			if clone == false :
				if menu.yes :
					menu.add += 1
					count.text = str(menu.add)
				else :
					count.text = "сломанная фигня"
				if menu.add == 666 :
					menu.yes = false
					for i in range(50):
						var dup = self.duplicate()
						dup.clone = true
						dup.position = self.position + Vector2(50, 0)
						menu.get_parent().add_child(dup)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			icon.visible = false
			angry.visible = false
			heart.visible = !heart.visible
		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			icon.visible = false
			angry.visible = !angry.visible 
			heart.visible = false
