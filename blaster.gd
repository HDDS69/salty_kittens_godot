extends Area2D
var recoil_y = -300
var recoil_x
@export var bullet : PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_global_mouse_position().x) < 0 :
		$blaster.flip_v = true
		recoil_x = 1000
	else :
		$blaster.flip_v = false
		recoil_x = -1000
	#законментировать для мобильной версии
	look_at(get_global_mouse_position())
		
func shoot():
	$AudioStreamPlayer2D.play()
	$"..".count -=1
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Marker2D.global_transform
