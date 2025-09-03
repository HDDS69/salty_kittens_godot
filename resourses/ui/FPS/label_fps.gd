extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.text = "FPS : " + str(Engine.get_frames_per_second())
