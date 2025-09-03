extends Area2D

var SPEED = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += SPEED * transform.x


func _on_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != 'player' and body.name != "salty platform":
		body.death()
	queue_free()
