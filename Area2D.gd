extends Area2D

@onready var mob =  $".."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mob.chace:
		var pos = mob.player.position
		pos.x +=30 #+  randf_range(-15,15)
		look_at(pos)
