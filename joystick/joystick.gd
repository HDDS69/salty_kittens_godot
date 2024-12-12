extends Area2D


@onready var big = $big
@onready var small = $big/small
@onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(big.global_position)
		if not touched:
			if distance < max_distance:
				touched = true
		else : 
			small.position = Vector2(0,0)
			touched = false
func _process(delta):
	if touched:
		small.global_position = get_global_mouse_position()
		small.position = big.position + (small.position - big.position).limit_length(max_distance)

func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small.position.x / max_distance
	joy_velo.y = small.position.y / max_distance
	return joy_velo
	
