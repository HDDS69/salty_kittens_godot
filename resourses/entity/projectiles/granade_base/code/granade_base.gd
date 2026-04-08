extends RigidBody2D

var costil = false
var activation = false
@onready var radius = $radius
@onready var bomb = $bomb
@onready var sound = $sound
@onready var anim = $AnimatedSprite2D
@onready var timer = $Timer
var bomb_img
# функция смерти
func _ready() -> void:
	bomb_img = $bomb.texture
func death():
	if activation == true:
		radius.monitoring = true
		bomb.visible = false
		freeze = true
		sound.play()
		anim.play("default")
		await anim.animation_finished
		queue_free()

func damage(_dmg):
	activation = true
	death()
func stun():
	pass
# по окончанию таймера вызывается функция смерти
func _on_timer_timeout():
	death()

# проверяем тела которые находятся в радиусе взрыва и наносим урон если есть в радиусе
func _on_radius_body_entered(body):
	if body.name != "player" and body.has_method('damage') :
		body.damage(1)

# при соприкосновении к любому телу начинается 1секундный таймер
func _on_body_shape_entered(_body_rid: RID, _body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if costil == false :
		costil = true
		timer.start()


func _on_take_body_entered(body: Node2D) -> void:
	if body.name == "player" and activation == false:
		if body.inventory.size() < 3:
			body.take([load(scene_file_path),bomb_img])
			queue_free()
