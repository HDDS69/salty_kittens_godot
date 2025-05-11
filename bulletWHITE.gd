extends Area2D

var SPEED = 15
var whitelist = [
	'mob',
	'mob2',
	'mob3',
	'mob4',
	'mob5',
	'mob6',
	'TileMap',
	'salty platform',
]
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += SPEED * transform.x


func _on_body_entered(body):
	#if body.name not in whitelist:	
	#queue_free()
	if body.name == 'player':
		body.health -=1
	if body.name == 'TileMapLayer':
		queue_free()
