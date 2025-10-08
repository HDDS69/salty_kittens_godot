extends RigidBody2D

enum states {idle,fly,attack,death}
var state: states = states.idle
var hp = 12313

func _process(delta: float) -> void:
	if state == states.idle:
		$"..".progress_ratio += delta * 0.1
	elif state == states.death:
		death()

func death():
	
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()

func damage(dmg):
	hp -= dmg
	if hp <= 0:
		state = states.death
