extends RigidBody2D

enum states {idle,attack,wait,death}
var state: states = states.idle
var hp = 5

func _process(_delta: float) -> void:
	if state == states.idle:
		pass
	elif state == states.attack:
		linear_velocity.x = 150 #7500 * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and state == states.idle:
		if state != states.wait:
			state = states.wait
			$Timer.start(5)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player" and state != states.attack and state != states.death:
		state = states.idle
	
func _on_timer_timeout() -> void:
	state = states.attack

func damage(dmg):
	hp -= dmg
	if hp <= 0:
		state = states.death
		death()

func death():
	$Area2D3.monitoring = true
	#queue_free()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if (body.name == 'player' or body.name == 'TileMapLayer') and state == states.attack:
		death()


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.name != 'TileMapLayer' and body.name != "salty platform":
		body.damage(1)
		queue_free()
