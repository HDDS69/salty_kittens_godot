extends Area2D
var recoil_y = -300
var recoil_x
@export var bullet : PackedScene
@onready var blaster = $blaster
@onready var sound = $AudioStreamPlayer2D
@onready var pl = $".."
@onready var marker = $Marker2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if (get_global_mouse_position().x) < 0 :
		blaster.flip_v = true
		recoil_x = 1000
	else :
		blaster.flip_v = false
		recoil_x = -1000
	#законментировать для мобильной версии
	look_at(get_global_mouse_position())
		
func shoot():
	sound.play()
	pl.count -=1
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = marker.global_transform
