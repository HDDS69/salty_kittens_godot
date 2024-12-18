extends Area2D
var recoil_y = -300
var recoil_x
@export var bullet : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if get_local_mouse_position().y > 0:
	#	recoil_y = -300
	#elif get_local_mouse_position().y < 0:
	#	recoil_y = 300
	if (get_global_mouse_position().x) < 0 :
		$blaster.flip_v = true
		recoil_x = 1000
	else :
		$blaster.flip_v = false
		recoil_x = -1000
	var pos = $"../mobile controller/MarginContainer/joystick".get_velo() * 10000
	#look_at(pos)
	#законментировать для мобильной версии
	look_at(get_global_mouse_position())
func shoot():
	#$"..".recharge = false
	$"..".count -=1
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Marker2D.global_transform
	#$"..".velocity.y += recoil_y
	#$"..".velocity.x = recoil_x
