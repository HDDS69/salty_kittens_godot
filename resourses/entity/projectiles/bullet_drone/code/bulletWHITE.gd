extends Area2D

var SPEED = 10
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position += SPEED * transform.x


func _on_body_entered(body):
	if body.name == 'player':
		body.damage(1)
		queue_free()
	if body == TileMapLayer:
		queue_free()
