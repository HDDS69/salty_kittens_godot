extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"..".chace:
		var pos = $"..".player.position
		pos.x +=30
		look_at(pos)
	
