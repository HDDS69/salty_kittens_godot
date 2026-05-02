extends Area2D

@export var bullet : PackedScene
@onready var blaster = $blaster
@onready var sound = $AudioStreamPlayer2D
@onready var pl = $".."
@onready var marker = $Marker2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if get_transform().x[0] < 0 :
		blaster.flip_v = true
	else :
		blaster.flip_v = false
	# TODO законментировать для мобильной версии
	look_at(get_global_mouse_position())
		
func shoot():
	sound.play()
	pl.count -=1
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.transform = marker.global_transform
