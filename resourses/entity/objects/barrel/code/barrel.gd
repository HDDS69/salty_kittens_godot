extends RigidBody2D

@onready var colis = $CollisionShape2D
@onready var barrel = $Barrel
@onready var anim = $AnimatedSprite2D

func death():
	colis.set_deferred("disabled", true);
	self.gravity_scale = 0.0
	barrel.visible = false
	anim.play("explosion")
	await anim.animation_finished
	queue_free()

func damage(dmg):
	if dmg >= 1:
		death()
