extends RigidBody2D

@export var bullet : PackedScene
enum states {idle,fly,attack,death,recharge,attack_timer,recharge_timer}
var state: states = states.idle
var hp = 3
var count = 0
var x = 0
var y = 0
var player

func _process(_delta: float) -> void:
	$ProgressBar.value = hp
	if state == states.idle:
		$"..".progress_ratio += _delta * 0.1
		self.position.y += sin(y) * 0.15
		#self.position.x += cos(x) * 10
		x += 1
		y +=0.1	
	elif state == states.death:
		death()
	elif state == states.attack:
		var pos = player.position 
		$muzzle.look_at(pos)
		if $"time to shot".is_stopped():
			$"time to shot".start()
	elif state == states.recharge:
		state = states.recharge_timer
		if $recharge.is_stopped():
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
		player = body
		state = states.attack
		
func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "player":
		state = states.idle

func _on_timer_timeout() -> void:
	state = states.attack

func _on_time_to_shot_timeout() -> void:
	attack()
