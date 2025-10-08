extends RigidBody2D

enum states {idle,fly,attack,death }
var state: states = states.idle

func _process(delta: float) -> void:
	if state == states.idle:
		death()

func death():
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()
