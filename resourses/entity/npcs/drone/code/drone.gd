extends RigidBody2D

enum states {idle,fly,attack,death}
var state: states = states.idle
var hp = 3

func _process(delta: float) -> void:
	$ProgressBar.value = hp
	if state == states.idle:
		$"..".progress_ratio += delta * 0.1
	elif state == states.death:
		death()
	elif state == states.attack:
		attack()

func death():
	gravity_scale = 1.0
	inertia = 1.0
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func damage(dmg):
	hp -= dmg
	if hp <= 0:
		state = states.death

func attack():
	pass

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		state = states.attack
