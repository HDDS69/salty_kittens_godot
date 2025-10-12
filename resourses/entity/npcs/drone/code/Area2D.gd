extends Area2D

#@onready var drone =  $".."
#@export var player : Node2D
var x1 = 0
var x2 = 0
var dir = 0
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if drone.state == drone.states.attack :
		var pos = $"..".player.position 
		pos.x +=30 #+  randf_range(-15,15)
		look_at(pos)
		#x1 = player.position.x - 150
		#x2 = player.position.x + 150
		##var direction = to_local(player.global_position).normalized()
		#dir = player.position.x - drone.position.x
		#print(dir)
		#drone.linear_velocity.x = 150 * 1
		#if drone.position.x <= x1:
			#drone.linear_velocity.x -= delta * 0.1
		#elif drone.position.x >= x2 :
			#drone.linear_velocity.x += delta * 0.1
		#else: 
			#drone.linear_velocity.x += delta * 0.1
