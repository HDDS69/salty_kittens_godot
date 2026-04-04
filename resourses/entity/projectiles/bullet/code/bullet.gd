extends Area2D

var SPEED = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position += SPEED * transform.x


func _on_body_entered(body):
# TODO #11 нужно сделать так чтобы оно игнорировало тайлмапы по типу объекта а не по имени
	if body.name != 'TileMapLayer' and body.name != 'player' and body.name != "salty platform" and body.name != 'barwood ground':
		body.damage(1)
	queue_free()
