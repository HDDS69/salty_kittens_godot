extends Area2D

var SPEED = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED * transform.x


func _on_body_entered(body):
	if body.name != 'TileMapLayer' and body.name != 'player' and body.name != "salty platform":
		body.death()
	queue_free()
