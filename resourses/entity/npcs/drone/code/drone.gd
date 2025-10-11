extends RigidBody2D

@export var bullet : PackedScene
enum states {idle,fly,attack,death,recharge,attack_timer,recharge_timer}
var state: states = states.idle
var hp = 3
var count = 0
var can_shoot = true

func _process(delta: float) -> void:
	$ProgressBar.value = hp
	if state == states.idle:
		$"..".progress_ratio += delta * 0.1
	elif state == states.death:
		death()
	elif state == states.attack:
		pass
	elif state == states.recharge:
		state = states.recharge_timer
		$recharge.start()
		

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
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $muzzle/Marker2D.global_transform
	
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		state = states.attack
		
func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "player":
		state = states.idle

func _on_timer_timeout() -> void:
	state = states.attack

func _on_time_to_shot_timeout() -> void:
	attack()
