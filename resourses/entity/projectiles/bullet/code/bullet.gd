extends Area2D

var SPEED = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position += SPEED * transform.x


func _on_body_entered(body):
	if body.name != 'player' and body.has_method('damage') :
		body.damage(1)
	queue_free()
