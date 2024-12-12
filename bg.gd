extends ParallaxBackground
var speed = 25



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= speed * delta
