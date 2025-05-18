extends Area2D

var recoil_y = -300
var recoil_x
@onready var big = $big
@onready var small = $big/small
@onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

#func _input(event):
	#if event is InputEventScreenTouch:
		#var distance = event.position.distance_to(big.global_position)
		#if not touched:
			#if distance < max_distance:
				#touched = true
		#else : 
			#small.position = Vector2(0,0)
			#touched = false
func _process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction != Vector2.ZERO:  # Проверка, движется ли игрок
		var target_rotation = input_direction.angle()  # Получаем угол для вращения
		$"../../../blaster".rotation = target_rotation  # Поворачиваем игрока в сторону движения
		
	

func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small.position.x / max_distance
	joy_velo.y = small.position.y / max_distance
	return joy_velo
	
