extends "res://resourses/entity/projectiles/granade_base/code/granade_base.gd"
func _on_radius_body_entered(body):
	if body.has_method('stun'):
		body.stun()
